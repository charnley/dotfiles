#!/bin/bash

# set -x
set -e

cd ~/opt

mkdir -p neovim
cd neovim

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage

# ln -s ~/opt/neovim/nvim.appimage ~/bin/vim
