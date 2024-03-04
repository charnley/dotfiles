#!/bin/bash

set -x
set -e
set -u

dwnl=$HOME/dwnl
install=$HOME/opt/miniforge

mkdir -p $dwnl

wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -O $dwnl/miniforge.sh
bash $dwnl/miniforge.sh -b -p $install
