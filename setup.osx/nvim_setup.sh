#!/bin/bash

cd ~/opt

mkdir neovim
cd neovim

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
tar xzf nvim-macos.tar.gz

ln -s ~/bin/vim ~/opt/neovim/nvim-osx64/bin/nvim

