#!/bin/bash

xcode-select --install

export NONINTERACTIVE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_PREFIX="$HOME/opt/homebrew"

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
