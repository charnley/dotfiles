#!/bin/bash
#
# cd $HOME/opt
#
# git clone https://github.com/vim/vim.git vim_build --depth 1
#
# cd vim_build
    # --with-python3-config-dir=$HOME/opt/miniconda3/lib/python3.7/config-3.7m-x86_64-linux-gnu \


./configure --with-features=huge \
    --enable-python3interp=yes \
    --prefix=$HOME/opt/vim

# make

