#!/bin/bash

# TODO
# use source .vimrc_module
# and then use vim -u .vimrc_modules
# so no settings are used

vim +PlugInstall +PlugUpgrade +PlugClean! +qall
