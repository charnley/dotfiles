#!/bin/bash

OPT=$HOME/opt

mkdir -p $OPT
cd $OPT

echo "Installing libevent"

mkdir -p libevent
cd libevent
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
tar xvzf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure --prefix $OPT/libevent
make install


# TODO tmux
cd $OPT
mkdir -p tmux
cd tmux
git clone https://github.com/tmux/tmux tmux-git
cd tmux-git
./configure --prefix=$OPT/tmux CFLAGS="-I$OPT/libevent/include" LDFLAGS="-L$OPT/libevent/lib"


# Install it
echo "Installing tmux bin"
cd $HOME/bin
ln -s $HOME/opt/tmux/bin/tmux tmux

#
echo "Done tmux"
echo "Remmeber to export libevent/lib to your LD_LIBRARY_PATH enviroment"


