FROM ernst-fastl/devbox-base


COPY ./brew-packages.txt /opt/devbox/devbox-helm-brew-packages.txt
COPY ./apt-packages.txt /opt/devbox/devbox-helm-apt-packages.txt

RUN /opt/devbox/apt-clean-install.sh /opt/devbox/devbox-base-helm-packages.txt &&\
/opt/devbox/brew-clean-install.sh /opt/devbox/devbox-helm-brew-packages.txt