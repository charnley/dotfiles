#!/bin/bash

# set -x
set -e

source ~/opt/nvm/nvm.sh

nvm use node

npm install --location=global npm-check
npm install --location=global npm-check-updates # ncu
