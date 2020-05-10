#!/bin/bash

configdir=`python3-config --configdir`
prefix=$HOME/opt/vim
install_dir=vim_build

cd $HOME/opt

git clone https://github.com/vim/vim.git $install_dir --depth 1

cd $install_dir


# Needs to have a python3 env activated
conda activate

# Clean up after yourself
make distclean

# TODO
# --enable-rubyinterp=yes \
# --enable-perlinterp=yes \
# --enable-luainterp=yes \
# --enable-gui=gtk2 \

./configure --with-features=huge \
    --enable-cscope \
    --enable-multibyte \
    --enable-python3interp=yes \
    --with-python3-config-dir=$configdir \
    --prefix=$HOME/opt/vim

make

make install

