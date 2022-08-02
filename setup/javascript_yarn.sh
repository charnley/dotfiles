#!/bin/bash

# set -x
set -e

source ~/opt/nvm/nvm.sh

nvm use node

npm install --location=global yarn --no-progress
