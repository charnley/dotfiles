#!/bin/bash

cd $HOME/dwnl/

wget https://raw.githubusercontent.com/mamba-org/micromamba-releases/main/install.sh

# Install without asking questions. Will install default places
echo | bash install.sh
