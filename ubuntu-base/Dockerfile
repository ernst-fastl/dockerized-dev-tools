FROM ubuntu:rolling

RUN yes | unminimize

RUN apt update -y && apt upgrade -y && apt autoremove -y 

RUN mkdir -p /opt/devbox && \
  echo 'export PATH=$PATH:/opt/devbox' >> /etc/profile

WORKDIR /opt/devbox

COPY /ubuntu-base/custom-profiled-loader.sh /etc/profile.d/custom-profiled-loader.sh
RUN chown root:root /etc/profile.d/custom-profiled-loader.sh
RUN chmod 755 /etc/profile.d/custom-profiled-loader.sh


COPY /scripts/container/* .
RUN chmod +x *.sh

RUN ./apt_clean_install.sh sudo

# root shell to bash
RUN chsh --shell /bin/bash root

# rename default user and add to sodoers
RUN usermod -l user ubuntu && \
groupmod -n user ubuntu && \
usermod -d /home/user -m user && \
usermod -c "Main Container User" user && \
echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN ./install_homebrew.sh

ENTRYPOINT ["/bin/bash", "--login"]