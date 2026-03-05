#!/bin/bash

set -x
set -e
set -u

cd $HOME/opt/
git clone https://github.com/zk-org/zk.git zk.git --depth 1
cd zk.git
make build

ln -s $HOME/opt/zk.git/zk $HOME/bin/zk
