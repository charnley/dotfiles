#!/bin/bash

set -euo pipefail

export NVM_DIR=$HOME/opt/nvm
mkdir -p $NVM_DIR

# Will install to $NVM_DIR
# TODO Don't change bashrc

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# Install version of now
source ${NVM_DIR}/nvm.sh

# Install newest stable node and npm
nvm install node --no-progress
