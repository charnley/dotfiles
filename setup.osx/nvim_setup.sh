#!/bin/bash

set -x
set -e

cd ~/opt

mkdir -p neovim
cd neovim

# version="nightly"
version="latest"

curl -LO https://github.com/neovim/neovim/releases/$version/download/nvim-macos.tar.gz
tar xzf nvim-macos.tar.gz

ln -s $HOME/opt/neovim/nvim-osx64/bin/nvim $HOME/bin/vim
chmod +x $HOME/bin/vim

$HOME/bin/vim --version

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
