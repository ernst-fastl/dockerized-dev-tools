#!/bin/bash

#!/bin/bash

set -e  # Exit on error

./apt_clean_install.sh perl perl-base perl-modules build-essential cpanminus

cpanm Carton
