FROM ubuntu:rolling

RUN yes | unminimize

RUN apt update -y && apt upgrade -y && apt autoremove -y 

# root shell to bash
RUN chsh --shell /bin/bash root

# rename default user and add to sodoers
RUN usermod -l user ubuntu && \
groupmod -n user ubuntu && \
usermod -d /home/user -m user && \
usermod -c "Main Container User" user && \
echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /opt/devbox

WORKDIR /opt/devbox

COPY /scripts/container/* .
RUN chmod +x *.sh

RUN ./install_homebrew.sh

ENTRYPOINT ["/bin/bash", "--login"]