#!/bin/bash

srcdir=$HOME/opt/luarocks
installdir=$HOME/opt/local

mkdir -p $srcdir
cd $srcdir

version=3.8.0

wget https://luarocks.org/releases/luarocks-$version.tar.gz
tar zxpf luarocks-$version.tar.gz

cd luarocks-3.8.0

./configure --prefix=$installdir

make
make install
