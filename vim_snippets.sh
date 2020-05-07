#!/bin/bash

relative=`dirname "$0"`
cd $relative
base=`pwd`

ln -s $base/dot.vim/snippets  ~/.vim/snippets
ln -s $base/dot.vim/UltiSnips  ~/.vim/UltiSnips

