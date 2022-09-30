#!/bin/bash

# set -x
set -e

export NVM_DIR=$HOME/opt/nvm
mkdir -p $NVM_DIR

# Will install to $NVM_DIR
# TODO Don't change bashrc
curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
