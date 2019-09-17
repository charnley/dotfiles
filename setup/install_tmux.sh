#!/bin/bash

LD_LIBRARY_PATH=$HOME/opt/local/lib
TMUX_VERSION=2.9a

run_tmux=$HOME/opt/tmux-${TMUX_VERSION}/tmux

$run_tmux "$@"

