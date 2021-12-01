#!/bin/bash

cd ~/opt

mkdir neovim
cd neovim

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

ln -s ~/bin/vim ~/opt/neovim/nvim.appimage
