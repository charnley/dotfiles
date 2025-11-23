#!/bin/bash

# set -x
set -e

cd ~/opt

mkdir -p neovim
cd neovim

# gcc --version | awk '/gcc/ && ($3+0)>9.1{print "Version is greater than 9.1"}'
# https://github.com/neovim/neovim-releases/releases/download/v0.10.1/nvim.appimage
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage

# curl -LO https://github.com/neovim/neovim-releases/releases/latest/download/nvim.appimage
#curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim_x86_64.appimage
# curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
#wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage

# wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
# mv ./nvim-linux-x86_64.appimage nvim.appimage

chmod u+x nvim.appimage

# ln -s ~/opt/neovim/nvim.appimage ~/bin/vim
