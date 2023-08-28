# Find latest dotnet-sdk version in current ubuntu repo

LATEST_DOTNET_VERSION=$(apt-cache madison dotnet-sdk | awk '{print $3}' | head -n 1)

./apt_clean_install.sh "dotnet-sdk=$LATEST_DOTNET_VERSION" nuget msbuild