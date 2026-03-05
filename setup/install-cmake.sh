#!/bin/bash
cd $HOME/opt/download/
wget https://github.com/Kitware/CMake/releases/download/v3.18.2/cmake-3.18.2-Linux-x86_64.sh -O cmake.sh
bash ./cmake.sh --prefix=$HOME/opt/local --exclude-subdir
