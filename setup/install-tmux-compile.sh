#!/bin/bash

set -x
set -e
set -u

if command -v brew
then
    export OPENSSL_ROOT_DIR=`brew --prefix openssl`
fi

export CURL_OPTIONS="--silent --show-error"

TMUX_VERSION="3.8"
NCURSES_VERSION="6.5"
LIBEVENT_VERSION="2.1.12"

INSTALL_DIR="$HOME/opt"
LIBDIR="$HOME/opt/local"
DWNLLDIR="$HOME/deb/"

mkdir -p $INSTALL_DIR
mkdir -p $LIBDIR
mkdir -p $DWNLLDIR

cd $INSTALL_DIR

if test ! -f $DWNLLDIR/tmux-${TMUX_VERSION}.tar.gz
then
    curl -L -o $DWNLLDIR/tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
fi

if test ! -f $DWNLLDIR/libevent-${LIBEVENT_VERSION}.tar.gz
then
    curl -L -o $DWNLLDIR/libevent-${LIBEVENT_VERSION}.tar.gz https://github.com/libevent/libevent/archive/refs/tags/release-${LIBEVENT_VERSION}-stable.tar.gz
fi

if test ! -f $DWNLLDIR/ncurses-${NCURSES_VERSION}.tar.gz
then
    curl -L -o $DWNLLDIR/ncurses-${NCURSES_VERSION}.tar.gz https://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz
fi

# Always extract into fresh source trees so reruns don't reuse stale builds
rm -rf tmux-${TMUX_VERSION} libevent-release-${LIBEVENT_VERSION}-stable ncurses-${NCURSES_VERSION}
tar xzf $DWNLLDIR/tmux-${TMUX_VERSION}.tar.gz --directory $INSTALL_DIR
tar xzf $DWNLLDIR/libevent-${LIBEVENT_VERSION}.tar.gz --directory $INSTALL_DIR
tar xzf $DWNLLDIR/ncurses-${NCURSES_VERSION}.tar.gz --directory $INSTALL_DIR

# setup libevent
cd libevent-release-${LIBEVENT_VERSION}-stable
# glibc 2.36+ headers declare arc4random*() in <stdlib.h>, which clashes with
# libevent 2.1.12's bundled static arc4random.c ("static declaration of
# 'arc4random_buf' follows non-static declaration"). Rename libevent's private
# copies right before arc4random.c is included (after stdlib.h is already in).
sed -i 's|^#include "./arc4random.c"|#define arc4random_stir evutil_arc4random_stir\n#define arc4random_addrandom evutil_arc4random_addrandom\n#define arc4random_buf evutil_arc4random_buf\n#define arc4random_uniform evutil_arc4random_uniform\n#define arc4random evutil_arc4random\n&|' evutil_rand.c
grep -q 'define arc4random_buf evutil_arc4random_buf' evutil_rand.c
# ./configure --prefix=$LIBDIR --disable-shared
mkdir -p build
cd build
cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_INSTALL_PREFIX:PATH=$LIBDIR ..
make
make install
cd ..
cd ..
# setup ncurses
cd ncurses-${NCURSES_VERSION}
# GCC 15+ defaults to C23 where 'bool' is a keyword; ncurses' configure then
# fails to detect stdbool and curses.h redefines bool, breaking C/C++ builds.
# Pin C17 and skip parts tmux doesn't need (C++ binding, tests, Ada, manpages).
./configure --prefix=$LIBDIR CFLAGS="-std=gnu17" \
    --without-cxx --without-cxx-binding --without-tests --without-ada --without-manpages \
    --enable-pc-files --with-pkg-config-libdir=$LIBDIR/lib/pkgconfig
make
make install
cd ..

# tmux install flags
FLAGS1="-I$LIBDIR/include -I$LIBDIR/include/ncursesw -I$LIBDIR/include/ncurses"
FLAGS2="-L$LIBDIR/lib"
FLAGS3=""

# let tmux's configure find our libevent and ncursesw via pkg-config
export PKG_CONFIG_PATH="$LIBDIR/lib/pkgconfig"

# setup tmux
cd tmux-${TMUX_VERSION}
# Release tarballs ship a pre-generated cmd-parse.c, so yacc is only needed to
# satisfy configure's check. Skip the check if no yacc/bison is installed.
YACC_OVERRIDE=""
if ! command -v yacc &> /dev/null && ! command -v bison &> /dev/null
then
    YACC_OVERRIDE="found_yacc=yes"
fi
./configure --disable-utf8proc CPPFLAGS="${FLAGS1}" CFLAGS="${FLAGS1}" LDFLAGS="${FLAGS2}" ${YACC_OVERRIDE}
CPPFLAGS="$FLAGS3" LDFLAGS="-static ${FLAGS2}" make

cd ..

rm -rf tmux
mv tmux-${TMUX_VERSION} tmux

echo "done"
