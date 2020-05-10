#!/bin/bash

ver=2.26.1

wget https://github.com/git/git/archive/v${VER}.tar.gz -O $HOME/opt/git-${VER}.tar.gz
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O $HOME/.git-prompt.sh

cd $HOME/opt/
tar -zxf git-${VER}.tar.gz
cd git-${VER}

make configure

./configure --prefix=$HOME/opt/git

make all doc info

make install

