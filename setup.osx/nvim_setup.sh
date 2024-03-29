#!/bin/bash

# set -x
set -e

cd ~/opt

mkdir -p neovim
cd neovim

# version="nightly"
version="latest"

curl -LO https://github.com/neovim/neovim/releases/$version/download/nvim-macos.tar.gz
tar xzf nvim-macos.tar.gz

ln -s $HOME/opt/neovim/nvim-macos/bin/nvim $HOME/bin/vim

$HOME/bin/vim --version 1> /dev/null # Check version is there, exit 1 if something failed
