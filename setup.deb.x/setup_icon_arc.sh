#!/bin/bash

set -x
set -e
set -u

mkdir -p ~/dwnl/
cd ~/dwnl/

git clone https://github.com/horst3180/arc-icon-theme --depth 1
cd arc-icon-theme

sudo rsync -av Arc /usr/share/icons

cd ..
