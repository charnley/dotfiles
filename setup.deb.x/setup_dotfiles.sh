#!/bin/bash

cwd=`pwd`

# $HOME
ln -sf $cwd/dot/vimrc $HOME/.vimrc
ln -sf $cwd/dot/gitconfig $HOME/.gitconfig
ln -sf $cwd/dot/bashrc $HOME/.bashrc
ln -sf $cwd/dot/bash_aliases $HOME/.bash_aliases
ln -sf $cwd/dot/bash_profile $HOME/.bash_profile
ln -sf $cwd/dot/inputrc $HOME/.inputrc
ln -sf $cwd/dot/tmux.conf $HOME/.tmux.conf
ln -sf $cwd/dot/condarc $HOME/.condarc
ln -sf $cwd/dot/gitconfig $HOME/.gitconfig

# i3 / urxvt
mkdir -p $HOME/.i3
mkdir -p $HOME/.config/i3status
ln -sf $cwd/dot.deb.x/Xresources $HOME/.Xresources
ln -sf $cwd/dot.deb.x/i3status $HOME/.config/i3status/config
ln -sf $cwd/dot.deb.x/i3config $HOME/.i3/config

# .ssh
mkdir -p $HOME/.ssh
ln -sf $cwd/dot/ssh_config $HOME/.ssh/config

# .config
ln -sf $cwd/dot.deb.x/dunstrc $HOME/.config/dunstrc

# vim
mkdir -p $HOME/.config/nvim
ln -sf $cwd/dot/neovim/init.vim $HOME/.config/nvim/init.vim
ln -sf $cwd/dot/neovim/lua $HOME/.config/nvim/lua
ln -sf $cwd/dot/neovim/snippets $HOME/.vsnip
