#!/bin/bash

version="5.4.3"
lua_build="$HOME/opt/lua_build"

mkdir -p $lua_build
cd $lua_build

curl -R -O http://www.lua.org/ftp/lua-$version.tar.gz
tar -zxf lua-$version.tar.gz
cd lua-$version

make linux test

make install
