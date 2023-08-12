FROM ubuntu:rolling

RUN yes | unminimize

RUN apt update -y && apt upgrade -y && apt autoremove -y 

RUN mkdir -p /opt/devbox
COPY scripts/* /opt/devbox
RUN chmod +x /opt/devbox/*.sh

RUN /opt/devbox/install-homebrew.sh

# root shell to bash
RUN chsh --shell /bin/bash root

# rename default user and add to sodoers
RUN usermod -l user ubuntu && \
groupmod -n user ubuntu && \
usermod -d /home/user -m user && \
usermod -c "Main Container User" user && \
echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENTRYPOINT ["/bin/bash", "--login"]