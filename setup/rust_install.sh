#!/bin/bash

# export RUSTUP_HOME=${HOME}/opt/rust
# export CARGO_HOME=${HOME}/opt/cargo

# mkdir -p $RUSTUP_HOME
# mkdir -p $CARGO_HOME


# curl https://sh.rustup.rs -sSf | sh -s -- --help
# USAGE:
#     rustup-init [FLAGS] [OPTIONS]
# FLAGS:
#     -v, --verbose           Enable verbose output
#     -q, --quiet             Disable progress output
#     -y                      Disable confirmation prompt.
#         --no-modify-path    Don't configure the PATH environment variable
#     -h, --help              Prints help information
#     -V, --version           Prints version information
# OPTIONS:
#         --default-host <default-host>              Choose a default host triple
#         --default-toolchain <default-toolchain>    Choose a default toolchain to install
#         --default-toolchain none                   Do not install any toolchains
#         --profile [minimal|default|complete]       Choose a profile
#     -c, --component <components>...                Component name to also install
#     -t, --target <targets>...                      Target name to also install

args="--no-modify-path -y --quiet"

curl https://sh.rustup.rs -sSf | sh -s -- $args

# TODO Add rust to PATHS for update

source $HOME/.cargo/env

# always just check for update
rustup update
