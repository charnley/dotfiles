#!/bin/bash

set -e
set -x

source ~/opt/nvm/nvm.sh

nvm use node

npm install -g npm-check
npm install -g npm-check-updates # ncu
