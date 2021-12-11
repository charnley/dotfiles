#!/bin/bash

set -e
set -x

export NVM_DIR=$HOME/opt/nvm
mkdir -p $NVM_DIR

# Will install to $NVM_DIR
curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
