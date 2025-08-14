#!/usr/bin/env bash

# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-cht.sh

# set -x
set -e
set -u

# Query cheat.sh in new tmux window

tmux neww -n "cheat" bash -c "cheat.sh"
