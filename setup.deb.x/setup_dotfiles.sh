#!/bin/bash

cwd=`pwd`

# ~
ln -sf $cwd/dot/vimrc ~/.vimrc
ln -sf $cwd/dot/gitconfig ~/.gitconfig
ln -sf $cwd/dot/bashrc ~/.bashrc
ln -sf $cwd/dot/bash_aliases ~/.bash_aliases
ln -sf $cwd/dot/bash_profile ~/.bash_profile
ln -sf $cwd/dot/inputrc ~/.inputrc
ln -sf $cwd/dot/tmux.conf ~/.tmux.conf
ln -sf $cwd/dot/condarc ~/.condarc
ln -sf $cwd/dot/gitconfig ~/.gitconfig

# i3
ln -sf $cwd/dot.deb.x/Xresources ~/.Xresources
ln -sf $cwd/dot.deb.x/i3status ~/.i3status
ln -sf $cwd/dot.deb.x/i3config ~/.i3/config

# .ssh
mkdir -p ~/.ssh
ln -sf $cwd/dot/ssh_config ~/.ssh/config

# .config
ln -sf $cwd/dot.deb.x/dunstrc ~/.config/dunstrc
mkdir -p ~/.config/nvim 
ln -sf $cwd/dot/neovim/init.vim ~/.config/nvim/init.vim
