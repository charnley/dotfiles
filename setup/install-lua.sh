#!/bin/bash

# TODO Should be 5.1.*

# https://lua.org/ftp/lua-5.4.8.tar.gz
version="5.4.8"
lua_build="$HOME/opt/lua_build"

mkdir -p $lua_build
cd $lua_build

wget http://lua.org/ftp/lua-$version.tar.gz
tar -zxf lua-$version.tar.gz
cd lua-$version

make linux test

# make install
