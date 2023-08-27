FROM ernst-fastl/ubuntu-base

COPY /scripts/container/* .
COPY /devbox-base/apt-packages.txt ./devbox-base-apt-packages.txt

RUN ./apt_clean_install.sh devbox-base-apt-packages.txt 