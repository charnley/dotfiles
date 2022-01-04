#!/usr/bin/env bash

# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-cht.sh

# set -x
# set -e
# set -u

# Query cheat.sh with fuzzy found query, in a scratch vim session

# TODO Make use of vim :set syntax=javascript for cheat output, based on query
# NOTE would be better if cheat.sh returns #shabang, but doubt
# NOTE some languages has been shortend, like js is javascript 

chtargs="T"
curlargs="--silent"
reader="vim -c \"set buftype=nofile\" -" # Open vim in scratch mode, no prompt on exit

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

curl "cht.sh/$query_item?$chtargs" ${curlargs} | vim -c "set buftype=nofile" -c "set syntax=bash" -
