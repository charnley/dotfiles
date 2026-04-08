#!/usr/bin/env bash

set -x
set -e
set -u

VERSION="6.5.1"
URL="https://use.fontawesome.com/releases/v${VERSION}/fontawesome-free-${VERSION}-desktop.zip"

if [[ $(uname -s) == Linux ]]
then
    INSTALL_DIR="${HOME}/.fonts/"
else
    INSTALL_DIR="${HOME}/Library/Fonts/"
fi


curl -LO "$URL"

unzip -o "fontawesome-free-${VERSION}-desktop.zip"

find . -type f \( -iname "*.otf" -o -iname "*.ttf" \) -exec cp {} "$INSTALL_DIR" \;
