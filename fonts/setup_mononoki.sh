#!/bin/bash

set -x
set -e
set -u

mkdir -p mononoki
cd mononoki

wget -O mononoki.zip https://github.com/madmalik/mononoki/blob/master/export/mononoki.zip?raw=true

unzip mononoki.zip

cd webfont

if [[ $(uname -s) == Linux ]]
then
    cp *.ttf ${HOME}/.fonts/
else
    # Darwin
    cp *.ttf ${HOME}/Library/Fonts/
fi
