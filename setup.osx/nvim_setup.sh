#!/bin/bash

set -x
set -e

cd ~/opt

mkdir -p neovim
cd neovim

# version="nightly"
# version="latest"
version="v0.10.0"

url=https://github.com/neovim/neovim/releases/download/$version/nvim-macos-arm64.tar.gz

curl -LO $url
tar xzf nvim-macos-arm64.tar.gz

ln -s $HOME/opt/neovim/nvim-macos-arm64/bin/nvim $HOME/bin/vim

$HOME/bin/vim --version 1> /dev/null # Check version is there, exit 1 if something failed
