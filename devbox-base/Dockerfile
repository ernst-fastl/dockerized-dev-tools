FROM ernst-fastl/ubuntu-base


COPY ./apt-packages.txt /opt/devbox/devbox-base-apt-packages.txt

RUN /opt/devbox/apt-clean-install.sh /opt/devbox/devbox-base-apt-packages.txt 