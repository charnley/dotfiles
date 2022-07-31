#!/bin/bash

# set -x
set -e

cd ~/opt

mkdir -p neovim
cd neovim

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

# ln -s ~/opt/neovim/nvim.appimage ~/bin/vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
