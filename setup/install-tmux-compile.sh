#!/usr/bin/env bash
#
# Compile tmux with static libevent and ncurses into ~/opt/tmux.
# Downloads and extracted sources are reused on re-run; delete them to start over.

set -euxo pipefail

TMUX_VERSION="3.8"
NCURSES_VERSION="6.5"
LIBEVENT_VERSION="2.1.12"

INSTALL_DIR="$HOME/opt"
LIBDIR="$HOME/opt/local"
DWNLDIR="$HOME/deb"

TMUX_SRC="tmux-${TMUX_VERSION}"
NCURSES_SRC="ncurses-${NCURSES_VERSION}"
LIBEVENT_SRC="libevent-${LIBEVENT_VERSION}-stable"

mkdir -p "$INSTALL_DIR" "$LIBDIR" "$DWNLDIR"
cd "$INSTALL_DIR"

# fetch <url> <source-dir>: download tarball and extract it, unless already present
fetch() {
    local url="$1"
    local src="$2"
    local tarball="$DWNLDIR/${src}.tar.gz"

    if [ ! -f "$tarball" ]; then
        curl --silent --show-error --fail --location --output "$tarball" "$url"
    fi

    if [ ! -d "$src" ]; then
        tar xzf "$tarball" --directory "$INSTALL_DIR"
    fi
}

fetch "https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${TMUX_SRC}.tar.gz" "$TMUX_SRC"
fetch "https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/${LIBEVENT_SRC}.tar.gz" "$LIBEVENT_SRC"
fetch "https://ftp.gnu.org/gnu/ncurses/${NCURSES_SRC}.tar.gz" "$NCURSES_SRC"

# libevent
(
    cd "$LIBEVENT_SRC"
    ./configure --prefix="$LIBDIR" \
        --disable-shared --disable-openssl --disable-samples --disable-libevent-regress
    make
    make install
)

# ncurses
(
    cd "$NCURSES_SRC"
    ./configure --prefix="$LIBDIR" CFLAGS="-std=gnu17" \
        --without-shared --without-cxx --without-cxx-binding \
        --without-tests --without-ada --without-manpages \
        --enable-pc-files --with-pkg-config-libdir="$LIBDIR/lib/pkgconfig"
    make
    make install
)

# tmux
export PKG_CONFIG_PATH="$LIBDIR/lib/pkgconfig"
INCLUDE_FLAGS="-I$LIBDIR/include -I$LIBDIR/include/ncursesw -I$LIBDIR/include/ncurses"
LIB_FLAGS="-L$LIBDIR/lib"

(
    cd "$TMUX_SRC"

    # Release tarballs ship a pre-generated cmd-parse.c, so yacc is only needed
    # to satisfy configure's check.
    YACC_OVERRIDE=()
    if ! command -v yacc > /dev/null && ! command -v bison > /dev/null; then
        YACC_OVERRIDE=("found_yacc=yes")
    fi

    ./configure --disable-utf8proc \
        CPPFLAGS="$INCLUDE_FLAGS" CFLAGS="$INCLUDE_FLAGS" LDFLAGS="$LIB_FLAGS" \
        "${YACC_OVERRIDE[@]+"${YACC_OVERRIDE[@]}"}"
    make
)

mkdir -p tmux
cp "$TMUX_SRC/tmux" tmux/tmux

