FROM ernst-fastl/ubuntu-base

COPY /scripts/container/* .
COPY /devbox-base/apt-packages.txt ./devbox-base-apt-packages.txt

RUN ./apt-clean-install.sh devbox-base-apt-packages.txt 