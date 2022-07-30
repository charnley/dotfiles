#!/bin/bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --depth 1

ls ~/bin
which tmux
export PATH=PATH:~/bin

bash ~/.tmux/plugins/tpm/tpm

