#!/bin/bash

cd ~/deb/

version=$(curl https://go.dev/VERSION?m=text | head -n 1)

wget "https://dl.google.com/go/$version.linux-amd64.tar.gz"
tar xvf $version.linux-amd64.tar.gz

mv go ~/opt/
ln -s ~/opt/go/bin/go ~/bin/go
