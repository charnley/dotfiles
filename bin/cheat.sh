#!/usr/bin/env bash

# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-cht.sh

# set -x
set -e
set -u

# Query cheat.sh with fuzzy found query, in a vim session

# TODO Make use of vim :set syntax=javascript for cheat output, based on query
# NOTE would be better if cheat.sh returns #shabang, but doubt
# NOTE some languages has been shortend, like js is javascript

chtargs="T"
curlargs="--silent"

IFS=$'
'

# TODO what if query is "python/list zip"
# --print-query prints the typed query first, followed by the selected item.
# Seperated by newline. Selected item can be empty
query=`curl http://cheat.sh/:list $curlargs | grep -v "rfc" | fzf --print-query`
query_raw=`echo $query | awk '{ print $1 }'` # print first column
query_item=`echo $query | awk '{ print $2}'` # print all but first column

unset IFS

# if no item selected in fzf, use the raw input
test -z "$query_raw" && exit 0
test -z "$query_item" && query_item=$query_raw

query_item=`echo $query_item | tr ' ' '+'`

# TODO Fix 'js' ->  'javascript'
# TODO Fix 'python3' -> 'python'
# TODO If not lang, fallback to sh
query_lang=${query_item%/*}

#echo $query_item

curl "cht.sh/$query_item?$chtargs" ${curlargs} | vim -c "set buftype=nofile" -c "set syntax=${query_lang}" -
