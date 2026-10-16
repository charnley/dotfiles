#!/bin/bash

set -x
set -e

# Official node binaries need libatomic.so.1, RHEL doesn't install it by default.
# Without sudo, unpack the rpm into $HOME/opt/libatomic

if ldconfig -p | grep -qF 'libatomic.so.1 '
then
    exit 0
fi

mkdir -p ~/opt/libatomic
cd ~/opt/libatomic

dnf download libatomic --arch $(uname -m)
rpm2cpio libatomic-*.rpm | cpio -idm
rm libatomic-*.rpm
