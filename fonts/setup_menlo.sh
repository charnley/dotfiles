#!/usr/bin/env bash

set -x
set -e
set -u

git clone git@github.com:abertsch/Menlo-for-Powerline.git menlo

if [[ $(uname -s) == Linux ]]
then
    cp menlo/*.ttf ${HOME}/.fonts/
else
    # Darwin
    cp menlo/*.ttf ${HOME}/Library/Fonts/
fi

rm -rf menlo
