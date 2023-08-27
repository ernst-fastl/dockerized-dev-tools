#!/bin/bash

#!/bin/bash

set -e  # Exit on error

./apt-clean-install.sh python-is-python3 python3-pip python3-argcomplete python3-autopep8 python3-pretty-yaml \
 python3-flake8 python3-venv virtualenv tox black isort flake8 mypy pylint sphinx