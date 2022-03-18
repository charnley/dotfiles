#!/bin/bash

# exit on error
set -e

TMUX_VERSION="3.2a"
NCURSES_VERSION="6.3"
LIBEVENT_VERSION="2.1.12"

INSTALL_DIR="$HOME/opt"
LIBDIR="$HOME/opt/local"
DWNLLDIR="$HOME/opt/download"

mkdir -p $INSTALL_DIR
mkdir -p $LIBDIR
mkdir -p $DWNLLDIR

cd $INSTALL_DIR

curl -L -o $DWNLLDIR/tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
curl -L -o $DWNLLDIR/libevent-${LIBEVENT_VERSION}.tar.gz https://github.com/libevent/libevent/archive/refs/tags/release-${LIBEVENT_VERSION}-stable.tar.gz
curl -L -o $DWNLLDIR/ncurses-${NCURSES_VERSION}.tar.gz https://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz

tar xvzf $DWNLLDIR/ncurses-${NCURSES_VERSION}.tar.gz --directory $INSTALL_DIR
tar xvzf $DWNLLDIR/libevent-${LIBEVENT_VERSION}.tar.gz --directory $INSTALL_DIR
tar xvzf $DWNLLDIR/tmux-${TMUX_VERSION}.tar.gz --directory $INSTALL_DIR

# setup libevent
cd libevent-release-${LIBEVENT_VERSION}-stable
# ./configure --prefix=$LIBDIR --disable-shared
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=$LIBDIR ..
make
make install
cd ..
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
CPPFLAGS="$FLAGS3" LDFLAGS="-static ${FLAGS2}" make

echo "done"
