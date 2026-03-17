#!/bin/bash

set -x
set -e
set -u

test ! -z "${ZK_NOTEBOOK_DIR}"

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
NOTES_ZK_DIR="${DOTFILES_DIR}/notes/zk"

test -d "${ZK_NOTEBOOK_DIR}"

ln -s "${NOTES_ZK_DIR}" "${ZK_NOTEBOOK_DIR}/.zk"
