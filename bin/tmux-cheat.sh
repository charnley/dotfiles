#!/usr/bin/env bash

# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-cht.sh

# set -x # for debug
# set -e # fzf needs exits non-zero for no items
set -u

chtargs="T"
curlargs="--silent"
reader="vim -"

IFS=$'
'

query=`curl http://cheat.sh/:list $curlargs | grep -v "rfc" | fzf --print-query`
query_raw=`echo $query | awk '{ print $1 }'`
query_item=`echo $query | awk '{ print $2 }'`

unset IFS

test -z "$query_raw" && exit 0
test -z "$query_item" && query_item=$query_raw

tmux neww bash -c "curl 'cht.sh/$query_item?$chtargs' $curlargs | $reader"
