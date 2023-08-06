FROM ubuntu:rolling

RUN yes | unminimize

RUN apt update -y && apt upgrade -y && apt autoremove -y 

COPY apt-upgrade-install-cleanup.sh /usr/local/bin/apt-upgrade-install-cleanup.sh
RUN chmod +x /usr/local/bin/apt-upgrade-install-cleanup.sh

RUN /usr/local/bin/apt-upgrade-install-cleanup.sh \
openssh-server bash-completion bash-doc man-db sudo \
gcc build-essential procps file \
git vim jq plocate  wget fzf \
ca-certificates curl gnupg \
dhcping iputils-ping iputils-tracepath iptraf-ng httpie nmap \
software-properties-common python-is-python3 python3-pip python3-argcomplete python3-autopep8 python3-pretty-yaml \
ruby-full ruby-dev rubygems 

# root shell to bash
RUN chsh --shell /bin/bash root

# install homebrew
RUN /bin/bash -c \
"NONINTERACTIVE=1 && $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /etc/profile

# rename default user and add to sodoers
RUN usermod -l user ubuntu && \
groupmod -n user ubuntu && \
usermod -d /home/user -m user && \
usermod -c "Main Container User" user && \
echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# update plocatedb

RUN updatedb

ENTRYPOINT ["/bin/bash", "--login"]