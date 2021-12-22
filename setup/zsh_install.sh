#!/bin/bash

set -u
set -e

builddir=$HOME/opt/zsh_build
installdir=$HOME/opt/zsh

mkdir -p $builddir
cd $builddir

wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download

mkdir -p zsh
unxz zsh.tar.xz
tar -xvf zsh.tar -C zsh --strip-components 1

cd zsh

./configure --prefix=$installdir
make
make install

ln -s ${HOME}/opt/zsh/bin/zsh ${HOME}/bin/zsh
