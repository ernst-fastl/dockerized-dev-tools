#!/bin/bash

# Find latest dotnet-sdk version in current ubuntu repo

apt update -y

latest_sdk=$(apt-cache search ^dotnet-sdk | grep -v 'source-built-artifacts' | awk '{print $1}' | sort -V | tail -n 1)

echo "Latest dotnet-sdk: $latest_sdk"

./apt_clean_install.sh --skip-update $latest_sdk nuget 