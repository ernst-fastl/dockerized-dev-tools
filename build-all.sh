#!/bin/bash

# Build the ubuntu-base image
cd ubuntu-base
../build-scripts/build-image.sh
cd ..

# Build the devbox-base image
cd devbox-base
../build-scripts/build-image.sh
cd ..
