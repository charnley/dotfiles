#!/bin/bash

set -e
set -x

source ~/opt/nvm/nvm.sh

# Install newest stable node and npm
nvm install node --no-progress
