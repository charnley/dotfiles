#!/usr/bin/env python3

import argparse
import html
import re
import sys
import urllib.error
import urllib.parse
import urllib.request


MONTHS = {
    "jan": "January",
    "january": "January",
    "feb": "February",
    "february": "February",
    "mar": "March",
    "march": "March",
    "apr": "April",
    "april": "April",
    "may": "May",
    "jun": "June",
    "june": "June",
    "jul": "July",
    "july": "July",
    "aug": "August",
    "august": "August",
    "sep": "September",
    "sept": "September",
    "september": "September",
    "oct": "October",
    "october": "October",
    "nov": "November",
    "november": "November",
    "dec": "December",
    "december": "December",
}


def normalize_doi(raw: str) -> str:
    doi = raw.strip()

    prefixes = [
        "https://doi.org/",
        "http://doi.org/",
        "https://dx.doi.org/",
        "http://dx.doi.org/",
        "doi:",
        "DOI:",
    ]

    for prefix in prefixes:
        if doi.startswith(prefix):
            doi = doi[len(prefix):]

    return doi.strip()


def fetch_bibtex(doi: str, timeout: int = 20) -> str:
    encoded_doi = urllib.parse.quote(doi, safe="/")

    url = f"https://doi.org/{encoded_doi}"

    request = urllib.request.Request(
        url,
        headers={
            "Accept": "application/x-bibtex;q=1",
            "User-Agent": "doi2bib/1.0",
        },
    )

    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            content_type = response.headers.get("Content-Type", "")
            data = response.read().decode("utf-8", errors="replace")

    except urllib.error.HTTPError as error:
        raise RuntimeError(
            f"Failed to fetch DOI: HTTP {error.code} {error.reason} {doi}"
        ) from error

    except urllib.error.URLError as error:
        raise RuntimeError(
            f"Failed to fetch DOI: {error.reason}"
        ) from error

    if not data.strip():
        raise RuntimeError("Failed to fetch DOI: empty response")

    if "@article" not in data.lower() and "@" not in data:
        raise RuntimeError(
            "DOI resolved, but the server did not return BibTeX"
        )

    return data


def safe_bibtex_key(key: str) -> str:
    return re.sub(r"[^A-Za-z0-9_:.+/-]", "_", key)


def replace_entry_key(bibtex: str, key: str) -> str:
    pattern = r"^(\s*@\w+\s*\{)[^,]+,"
    replacement = rf"\g<1>{key},"

    new_bibtex, count = re.subn(
        pattern,
        replacement,
        bibtex,
        count=1,
        flags=re.MULTILINE,
    )

    if count == 0:
        raise RuntimeError("Could not find a BibTeX entry key to replace")

    return new_bibtex


def normalize_field_names(bibtex: str) -> str:
    field_names = {
        "DOI": "doi",
        "ISSN": "issn",
        "URL": "url",
    }

    for old, new in field_names.items():
        bibtex = re.sub(
            rf"(?m)^(\s*){old}(\s*=)",
            rf"\1{new}\2",
            bibtex,
        )

    return bibtex


def normalize_months(bibtex: str) -> str:
    def replace_month(match: re.Match) -> str:
        prefix = match.group(1)
        value = match.group(2) or match.group(3)
        normalized = MONTHS.get(value.lower())

        if normalized is None:
            return match.group(0)

        return f"{prefix}{{{normalized}}}"

    return re.sub(
        r"(?i)(\bmonth\s*=\s*)(?:\{([^{}]+)\}|([A-Za-z]+))",
        replace_month,
        bibtex,
    )


def normalize_pages(bibtex: str) -> str:
    return re.sub(r"([0-9])[–—]([0-9])", r"\1--\2", bibtex)


def normalize_html(bibtex: str) -> str:
    bibtex = re.sub(
        r"(?is)<i>(.*?)</i>",
        lambda m: r"\textit{" + m.group(1).strip() + "}",
        bibtex,
    )

    bibtex = re.sub(
        r"(?is)<em>(.*?)</em>",
        lambda m: r"\textit{" + m.group(1).strip() + "}",
        bibtex,
    )

    bibtex = re.sub(r"(?is)<[^>]+>", "", bibtex)

    return html.unescape(bibtex)


def clean_bibtex(bibtex: str, key: str) -> str:
    bibtex = replace_entry_key(bibtex, key)
    bibtex = normalize_field_names(bibtex)
    bibtex = normalize_months(bibtex)
    bibtex = normalize_pages(bibtex)
    bibtex = normalize_html(bibtex)
    return bibtex.strip()


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Fetch BibTeX for a DOI and clean common formatting issues."
    )

    parser.add_argument(
        "doi",
        help="DOI, DOI URL, or dx.doi.org URL",
    )

    parser.add_argument(
        "--safe-key",
        action="store_true",
        help="Use a filesystem and BibTeX friendly key instead of the raw DOI",
    )

    args = parser.parse_args()

    doi = normalize_doi(args.doi)

    if not doi:
        print("Error: DOI is empty", file=sys.stderr)
        return 2

    key = safe_bibtex_key(doi) if args.safe_key else doi

    try:
        raw_bibtex = fetch_bibtex(doi)
        cleaned_bibtex = clean_bibtex(raw_bibtex, key)

    except RuntimeError as error:
        print(f"Error: {error}", file=sys.stderr)
        return 1

    print(cleaned_bibtex)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
