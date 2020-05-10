#!/bin/bash

# exit on error
set -e

TMUX_VERSION="2.9a"
NCURSES_VERSION="6.1"
LIBEVENT_VERSION="2.0.19"

INSTALL_DIR="$HOME/opt"
LIBDIR="$HOME/opt/local"
DWNLLDIR="$HOME/opt/download"

mkdir -p $INSTALL_DIR
mkdir -p $LIBDIR
mkdir -p $DWNLLDIR

cd $INSTALL_DIR

wget -O $DWNLLDIR/tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
wget -O $DWNLLDIR/libevent-${LIBEVENT_VERSION}.tar.gz https://github.com/downloads/libevent/libevent/libevent-${LIBEVENT_VERSION}-stable.tar.gz
wget -O $DWNLLDIR/ncurses-${NCURSES_VERSION}.tar.gz ftp://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz

tar xvzf $DWNLLDIR/ncurses-${NCURSES_VERSION}.tar.gz --directory $INSTALL_DIR
tar xvzf $DWNLLDIR/libevent-${LIBEVENT_VERSION}.tar.gz --directory $INSTALL_DIR
tar xvzf $DWNLLDIR/tmux-${TMUX_VERSION}.tar.gz --directory $INSTALL_DIR

# setup libevent
cd libevent-${LIBEVENT_VERSION}-stable
./configure --prefix=$LIBDIR --disable-shared
make
make install
cd ..

# setup ncurses
cd ncurses-${NCURSES_VERSION}
./configure --prefix=$LIBDIR
make
make install
cd ..

# tmux install flags
FLAGS1="-I$LIBDIR/include -I$LIBDIR/include/ncurses"
FLAGS2="-L$LIBDIR/lib -L$LIBDIR/include/ncurses -L$LIBDIR/include"

# setup tmux
cd tmux-${TMUX_VERSION}
./configure CFLAGS="${FLAGS1}" LDFLAGS="${FLAGS2}"
CPPFLAGS="$FLAGS1" LDFLAGS="-static ${FLAGS2}" make

# tmux is now compiled, see install_tmux.sh for running

