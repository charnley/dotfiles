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

# i3 / urxvt
mkdir -p $HOME/.i3
mkdir -p $HOME/.config/i3status
ln -sf $cwd/dot.deb.x/Xresources $HOME/.Xresources
ln -sf $cwd/dot.deb.x/i3status $HOME/.config/i3status/config
ln -sf $cwd/dot.deb.x/i3config $HOME/.i3/config

# .ssh
mkdir -p ~/.ssh
ln -sf $cwd/dot/ssh_config ~/.ssh/config

# .config
ln -sf $cwd/dot.deb.x/dunstrc ~/.config/dunstrc
mkdir -p $HOME/.config/nvim
ln -sf $cwd/dot/neovim/init.vim $HOME/.config/nvim/init.vim
ln -sf $cwd/dot/neovim/lua $HOME/.config/nvim/lua


