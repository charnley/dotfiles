#!/bin/bash

INSTALL_DIR=$HOME/opt/node

mkdir $INSTALL_DIR

curl -sL https://install-node.vercel.app/lts | bash -s -- --prefix=$INSTALL_DIR
