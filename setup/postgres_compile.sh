#!/bin/bash


install_dir=$HOME/opt/postgres
download_dir=$HOME/opt/download

cd $download_dir
git clone --depth 1 https://github.com/postgres/postgres.git postgres.git

cd postgres.git
./configure --prefix $install_dir --disable-rpath
export LD_RUN_PATH='$ORIGIN/../lib'
make -j 4
make install
