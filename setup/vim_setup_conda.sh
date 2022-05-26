#!/bin/bash

# set -x
set -e

# Create a conda env with depenencies to compile VIM
# - for py3 support

# TODO Vim also needs NODE env for COC
# TODO Create own env for vim

conda create --name vimenv python=3.6 --yes
conda activate vimenv
conda install ncurses libx11-devel-cos6-x86_64 libiconv glib libxml2 libpng cairo gxx_linux-64 --yes
