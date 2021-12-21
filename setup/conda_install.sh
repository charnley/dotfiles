#!/bin/bash

if [[ $(uname -s) == Linux ]]
then
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/opt/miniconda3.sh
else
    # Darwin
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O $HOME/opt/miniconda3.sh
fi

cd $HOME/opt
bash miniconda3.sh -b -p $HOME/opt/miniconda3
rm miniconda3.sh
