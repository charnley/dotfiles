#!/usr/bin/env bash

# NOTE, if used in Matplotlib, please reset cache by
# rm -r ~/.cache/matplotlib

set -e
set -x

src=xkcd-font.git

# git clone https://github.com/ipython/xkcd-font $src --depth 1

cp $src/xkcd-script/font/*.ttf ~/.fonts
cp $src/xkcd/build/* ~/.fonts

rm -fr $src

