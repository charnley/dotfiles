#!/bin/bash

# Dependencies
apt-get install libpango1.0-0

# Download deb package
wget -O dropbox_2015_10_28_amd64.deb https://www.dropbox.com/download?dl=packages/debian/dropbox_2015.10.28_amd64.deb

# Install dropbox
dpkg -i dropbox_2015_10_28_amd64.deb

# Remove installation file
rm      dropbox_2015_10_28_amd64.deb

