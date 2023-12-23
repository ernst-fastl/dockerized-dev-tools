#!/bin/bash

#!/bin/bash

set -e  # Exit on error

./apt_clean_install.sh texlive-latex-base \
    texlive-extra-utils \
    texlive-latex-extra \
    biber chktex latexmk make python3-pygments python3-pkg-resources \
    texlive-lang-chinese \
    texlive-lang-japanese

# Install necessary Perl modules for latexindent
cpanm Log::Dispatch::File \
    && cpanm YAML::Tiny \
    && cpanm File::HomeDir \
    && cpanm Unicode::GCString

