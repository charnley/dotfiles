#!/bin/bash

set -x
set -e

cd ~/opt

mkdir -p neovim
cd neovim

filename="nvim.appimage"

# wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage -O $filename
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage -O $filename

chmod u+x $filename
