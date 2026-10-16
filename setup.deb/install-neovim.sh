#!/bin/bash

set -x
set -e

case "$(uname -m)" in
    x86_64) arch=x86_64 ;;
    aarch64|arm64) arch=arm64 ;;
    *) echo "unsupported architecture: $(uname -m)"; exit 1 ;;
esac

# Official build requires glibc >= 2.34, older systems (e.g. RHEL 8) use neovim-releases
glibc=$(ldd --version | head -1 | grep -oE '[0-9]+\.[0-9]+$')
if printf '2.34\n%s\n' "$glibc" | sort -CV
then
    repo=neovim/neovim
else
    repo=neovim/neovim-releases
fi

filename="nvim-linux-${arch}.tar.gz"

mkdir -p ~/opt/neovim
cd ~/opt/neovim

rm -rf bin lib share
wget https://github.com/$repo/releases/latest/download/$filename -O $filename
tar xzf $filename --strip-components=1
rm $filename
