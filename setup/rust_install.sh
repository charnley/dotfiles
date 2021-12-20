#!/bin/bash

export RUSTUP_HOME=${HOME}/opt/rust
export CARGO_HOME=${HOME}/opt/cargo

args=-y --quiet --nomodift-path

curl https://sh.rustup.rs -sSf | sh -- $args

# always needed
$CARGO_HOME/bin/rustup update
