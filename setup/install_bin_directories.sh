#!/bin/bash

set -u
set -e

bin_dir="${1:-bin}"

pwd=`pwd`

for x in `ls $bin_dir`
do
    if ! test -f $HOME/bin/$x
    then
        echo ln -s $pwd/$bin_dir/$x $HOME/bin/$x
        ln -s $pwd/$bin_dir/$x $HOME/bin/$x
    fi
done

