#!/bin/bash

wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/opt/miniconda3.sh

cd $HOME/opt

bash miniconda3.sh -b -p $HOME/opt/miniconda3

