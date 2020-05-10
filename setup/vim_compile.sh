#!/bin/bash

configdir=`python3-config --configdir`
prefix=$HOME/opt/vim
install_dir=vim_build


# Switch folder and clone
cd $HOME/opt
git clone https://github.com/vim/vim.git $install_dir --depth 1
cd $install_dir

# Needs to have a python3 env activated
source $CONDA_PREFIX/etc/profile.d/conda.sh
conda activate

# TODO if conda activate fails; exit

# Ensure clean build
make distclean

# TODO Ensure and enable other interps
# --enable-rubyinterp=yes \
# --enable-perlinterp=yes \
# --enable-luainterp=yes \
# --enable-gui=gtk2 \

# Configure build
./configure --with-features=huge \
    --enable-cscope \
    --enable-multibyte \
    --enable-python3interp=yes \
    --with-python3-config-dir=$configdir \
    --prefix=$HOME/opt/vim

# Compile and link
make

# install to prefix
make install

