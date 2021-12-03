#!/bin/bash

git clone https://github.com/horst3180/arc-icon-theme --depth 1
cd arc-icon-theme

rsync -av Arc /usr/share/icons

# cp -r Arc /usr/share/icons/Arc

cd ..
rm -r arc-icon-theme

