#!/usr/bin/env bash

# Query cheat.sh with fuzzy found query, new tmux window, in a scratch vim
# session

# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-cht.sh

chtargs="T"
curlargs="--silent"
reader="vim -c 'set buftype=nofile' -" # Open vim in scratch mode, no prompt on exit

IFS=$'
'

# --print-query prints the typed query first, followed by the selected item.
# Seperated by newline. Selected item can be empty
query=`curl http://cheat.sh/:list $curlargs | grep -v "rfc" | fzf --print-query`
query_raw=`echo $query | awk '{ print $1 }'`
query_item=`echo $query | awk '{ print $2 }'`

unset IFS

test -z "$query_raw" && exit 0
test -z "$query_item" && query_item=$query_raw

tmux neww bash -c "curl 'cht.sh/$query_item?$chtargs' $curlargs | $reader"
