#!/bin/bash

set -x
set -e
set -u

mkdir -p ~/opt
mkdir -p ~/bin
mkdir -p ~/deb

cd ~/deb/

# Fetch latest git-lfs version
version=$(curl -s https://api.github.com/repos/git-lfs/git-lfs/releases/latest \
    | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'].lstrip('v'))")

# Detect OS
uname_out="$(uname -s)"
case "${uname_out}" in
    Linux*)   os="linux";  ext="tar.gz" ;;
    Darwin*)  os="darwin"; ext="zip"    ;;
    *)        echo "Unsupported OS: ${uname_out}"; exit 1 ;;
esac

# Detect architecture
arch_out="$(uname -m)"
case "${arch_out}" in
    x86_64)   arch="amd64" ;;
    arm64)    arch="arm64" ;;
    aarch64)  arch="arm64" ;;
    *)        echo "Unsupported architecture: ${arch_out}"; exit 1 ;;
esac

# Compose filename and URL
filename="git-lfs-${os}-${arch}-v${version}.${ext}"
url="https://github.com/git-lfs/git-lfs/releases/download/v${version}/${filename}"

echo "Downloading git-lfs ${version} for ${os}/${arch}..."
curl --silent --show-error -L -o "${filename}" "${url}"

# Extract
extract_dir="git-lfs-${version}"
rm -rf "${extract_dir}"
mkdir -p "${extract_dir}"

if [ "${ext}" = "tar.gz" ]; then
    tar -xf "${filename}" -C "${extract_dir}" --strip-components=1
else
    unzip -q "${filename}" -d "${extract_dir}"
    # zip has a top-level directory, flatten it
    inner=$(ls "${extract_dir}")
    mv "${extract_dir}/${inner}"/* "${extract_dir}/"
    rmdir "${extract_dir}/${inner}"
fi

# Install using bundled install.sh with PREFIX override
rm -rf ~/opt/git-lfs
mkdir -p ~/opt/git-lfs

PREFIX=~/opt/git-lfs bash "${extract_dir}/install.sh"

# Symlink binary to ~/bin
ln -sf ~/opt/git-lfs/bin/git-lfs ~/bin/git-lfs
