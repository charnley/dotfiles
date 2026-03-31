#!/bin/bash

# set -x
set -e
set -u

mkdir -p ~/dwnl/
cd ~/dwnl/

mkdir -p mononoki
cd mononoki

wget -O mononoki.zip https://github.com/madmalik/mononoki/releases/download/1.6/mononoki.zip

unzip mononoki

if [[ $(uname -s) == Linux ]]
then
    mkdir -p ~/.fonts
    cp *.ttf ${HOME}/.fonts/
else
    # Darwin
    cp *.ttf ${HOME}/Library/Fonts/
fi
