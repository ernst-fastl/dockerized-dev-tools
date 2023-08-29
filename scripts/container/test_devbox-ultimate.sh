#!/bin/bash

set -e # Exit on error

/opt/devbox/test_devbox-scripting.sh
/opt/devbox/test_devbox-dotnet.sh
/opt/devbox/test_devbox-java.sh
/opt/devbox/test_devbox-go.sh