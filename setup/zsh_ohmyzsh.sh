#!/bin/bash

set -u
set -e

args=--no-env 

# install oh-my-zsh to default path ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
