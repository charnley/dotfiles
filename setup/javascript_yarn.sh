#!/bin/bash

set -e
set -x

source ~/opt/nvm/nvm.sh

nvm use node
npm install --global yarn --no-progress
