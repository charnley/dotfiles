#!/bin/bash

set -x
set -e
set -u

test ! -d ~/opt/go/

mkdir -p ~/deb
cd ~/deb/

# Fetch latest Go version
version=$(curl -s https://go.dev/VERSION?m=text | head -n 1)

# Detect OS
uname_out="$(uname -s)"
case "${uname_out}" in
    Linux*)   os="linux";;
    Darwin*)  os="darwin";;
    *)        echo "Unsupported OS: ${uname_out}"; exit 1;;
esac

# Detect architecture
arch_out="$(uname -m)"
case "${arch_out}" in
    x86_64)   arch="amd64";;
    arm64)    arch="arm64";;
    aarch64)  arch="arm64";;
    *)        echo "Unsupported architecture: ${arch_out}"; exit 1;;
esac


# Compose filename
filename="$version.$os-$arch.tar.gz"

# Download the Go tarball using curl
echo "Downloading Go $version for $os/$arch..."
curl -L -o "$filename" "https://dl.google.com/go/$filename"

# Extract the tarball
tar -xvf "$filename"

# Install: move to ~/opt and symlink
mv go ~/opt/go

# Create or update symlink to ~/bin
ln -sf ~/opt/go/bin/go ~/bin/go
