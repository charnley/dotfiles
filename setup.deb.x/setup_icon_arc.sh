#!/bin/bash

mkdir -p ~/dwnl/
cd ~/dwnl/

git clone https://github.com/horst3180/arc-icon-theme --depth 1
cd arc-icon-theme

rsync -av Arc /usr/share/icons

cd ..
rm -fr arc-icon-theme

