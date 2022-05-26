#!/bin/bash

# set -x
set -e

# Needs a python env
# conda activate vimenv
# Needs to have a python3 env activated
# source $CONDA_PREFIX/etc/profile.d/conda.sh
# conda activate
# TODO conda activate ENVNAME
# TODO if conda activate fails; exit

configdir=`python3-config --configdir`
prefix=$HOME/opt/vim
install_dir=vim_build

echo $configdir

mkdir $prefix

# Switch folder and clone
cd $HOME/opt
# git clone https://github.com/vim/vim.git $install_dir --depth 1
cd $install_dir

# Ensure clean build
make distclean

# Ensure and enable other interps
# --enable-rubyinterp=yes \
# --enable-perlinterp=yes \
# --enable-luainterp=yes \
# --enable-gui=gtk2 \

# error: lto-wrapper failed
# Dont care about lik-time optimization
export LDFLAGS="-fno-lto"

# Configure build
./configure \
    --DCMAKE_CXX_COMPILER=$CXX \
    --with-features=huge \
    --enable-cscope \
    --enable-multibyte \
    --enable-python3interp=yes \
    --with-python3-config-dir=$configdir \
    --prefix=$HOME/opt/vim

# TODO prefix is ignored by configure

# Compile and link
make prefix=~/.local

# install to prefix
make install prefix=~/.local

