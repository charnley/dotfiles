#!/bin/bash

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

# --[no-]key-bindings  Enable/disable key bindings (CTRL-T, CTRL-R, ALT-C)
# --[no-]completion    Enable/disable fuzzy completion (bash & zsh)
# --[no-]update-rc     Whether or not to update shell configuration files
~/.fzf/install --key-bindings --completion --no-update-rc
