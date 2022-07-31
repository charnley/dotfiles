#!/bin/bash

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --depth 1

if ! command -v tmux &> /dev/null
then
    export PATH="$HOME/bin/:$PATH"
fi

bash ~/.tmux/plugins/tpm/tpm
