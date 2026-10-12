#!/bin/bash

source ${NVM_DIR}/nvm.sh

nvm use node

npm install -g --ignore-scripts @earendil-works/pi-coding-agent
