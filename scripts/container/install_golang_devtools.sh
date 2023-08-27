#!/bin/bash
set -e  # Exit on error

# Fetch latest Go version
LATEST_GO_VERSION=$(curl -s https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 | grep -oP '([0-9\.]+)')

# Download and install Go
wget "https://golang.org/dl/go${LATEST_GO_VERSION}.linux-amd64.tar.gz"
tar -xvf "go${LATEST_GO_VERSION}.linux-amd64.tar.gz"
mv go /usr/local
rm "go${LATEST_GO_VERSION}.linux-amd64.tar.gz"

# Set GOPATH and add to PATH
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc

# Install Go Dev Tools
go get -u github.com/nsf/gocode
go get -u github.com/uudashr/gopkgs/v2/cmd/gopkgs
go get -u github.com/ramya-rao-a/go-outline
go get -u github.com/acroca/go-symbols
go get -u golang.org/x/tools/cmd/guru
go get -u golang.org/x/tools/cmd/gorename
go get -u github.com/fatih/gomodifytags
go get -u github.com/haya14busa/goplay/cmd/goplay
go get -u github.com/josharian/impl
go get -u github.com/tylerb/gotype-live
go get -u github.com/rogpeppe/godef
go get -u github.com/zmb3/gogetdoc
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/sqs/goreturns
go get -u winterdrache.de/goformat/goformat
go get -u golang.org/x/lint/golint
go get -u github.com/cweill/gotests/...
go get -u github.com/alecthomas/gometalinter
go get -u github.com/mgechev/revive
go get -u honnef.co/go/tools/...

# Reload PATH
source ~/.bashrc
