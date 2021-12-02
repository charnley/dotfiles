#!/bin/bash

cd ~/opt

mkdir -p neovim
cd neovim

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
tar xzf nvim-macos.tar.gz

ln -s ~/opt/neovim/nvim-osx64/bin/nvim ~/bin/vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
