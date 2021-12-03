#!/bin/bash

mkdir mononoki
cd mononoki

wget -O mononoki.zip https://github.com/madmalik/mononoki/blob/master/export/mononoki.zip?raw=true

unzip mononoki.zip

cp *.ttf ~/.fonts

cd ..
rm -rf mononoki

