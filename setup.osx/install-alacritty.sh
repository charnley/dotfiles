#!/usr/bin/env bash

set -x
set -e
set -u

ALACRITTY_VERSION="0.17.0"

SRC_DIR="$HOME/opt/alacritty-src"
APP_DIR="/Applications"

command -v cargo > /dev/null || { echo "cargo not found"; exit 1; }

# xcrun may pick a newer SDK than the installed linker can read (e.g. a
# leftover beta SDK), so nothing links. If so, fall back to the default
# MacOSX.sdk symlink, which matches the installed toolchain.
if [ -z "${SDKROOT:-}" ]; then
    probe="$(mktemp -d)"
    printf 'int main(void){return 0;}\n' > "$probe/t.c"
    if ! cc "$probe/t.c" -o "$probe/t" 2> /dev/null; then
        export SDKROOT="$(xcode-select -p)/SDKs/MacOSX.sdk"
    fi
    rm -rf "$probe"
fi

if [ ! -d "$SRC_DIR" ]; then
    git clone --depth 1 --branch "v${ALACRITTY_VERSION}" \
        https://github.com/alacritty/alacritty.git "$SRC_DIR"
fi

cd "$SRC_DIR"
make app

cp -r target/release/osx/Alacritty.app "$APP_DIR/"

"$APP_DIR/Alacritty.app/Contents/MacOS/alacritty" --version
