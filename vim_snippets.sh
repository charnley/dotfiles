#!/bin/bash

relative=`dirname "$0"`
cd $relative
base=`pwd`

ln -s $base/dotvim/snippets  ~/.vim/snippets

