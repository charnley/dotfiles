#!/bin/bash

# Setup node development package managers

# set -x
set -e

source ~/opt/nvm/nvm.sh

nvm use node

npm install --location=global yarn --no-progress
npm install --location=global pnpm --no-progress
