#!/usr/bin/env bash

# set -x
set -e
set -u

# NOTE, if used in Matplotlib, please reset cache by
# rm -r ~/.cache/matplotlib

src=xkcd-font.git

git clone https://github.com/ipython/xkcd-font $src --depth 1

if [[ $(uname -s) == Linux ]]
then
    cp $src/xkcd-script/font/*.ttf ${HOME}/.fonts
    cp $src/xkcd/build/* ${HOME}/.fonts
else
    # Darwin
    cp $src/xkcd-script/font/*.ttf ${HOME}/Library/Fonts/
    cp $src/xkcd/build/* ${HOME}/Library/Fonts/
fi

rm -fr $src
