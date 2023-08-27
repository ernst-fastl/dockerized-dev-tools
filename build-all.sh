#!/bin/bash

set -ex  # Exit on error & Echo all commands

./build.sh "$@" ubuntu-base
./build.sh "$@" devbox-base
./build.sh "$@" devbox-helm
./build.sh "$@" devbox-python
./build.sh "$@" devbox-ruby
./build.sh "$@" devbox-perl
./build.sh "$@" devbox-node
./build.sh "$@" devbox-java
./build.sh "$@" devbox-dotnet
./build.sh "$@" devbox-go
./build.sh "$@" devbox-ultimate