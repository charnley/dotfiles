#!/bin/bash

set -u
set -e

export KEEP_ZSHRC=yes
export RUNZSH=no
export CHSH=no

# install oh-my-zsh to default path ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
