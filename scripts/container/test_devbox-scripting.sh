#!/bin/bash

set -e # Exit on error

/opt/devbox/test_devbox-ruby.sh
/opt/devbox/test_devbox-powershell.sh
/opt/devbox/test_devbox-python.sh
/opt/devbox/test_devbox-node.sh