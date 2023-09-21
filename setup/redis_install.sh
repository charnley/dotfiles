#!/bin/bash

set -x
set -e
set -u

mkdir -p $HOME/deb/
mkdir $HOME/opt/redis

cd $HOME/deb/

wget https://download.redis.io/redis-stable.tar.gz

tar -xzvf redis-stable.tar.gz
cd redis-stable

make
make PREFIX=$HOME/opt/redis/ install
