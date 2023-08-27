#!/bin/bash

set -ex  # Exit on error & Echo all commands

./build.sh "$@" ubuntu-base
./build.sh "$@" devbox-base
./build.sh "$@" devbox-helm
./build.sh "$@" devbox-ultimate