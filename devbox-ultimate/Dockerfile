FROM ernst-fastl/devbox-helm

COPY /scripts/container/* .

RUN ./install-java-devtools.sh && \
./install-node-devtools.sh && \
./install-golang-devtools.sh  && \
./install-python-devtools.sh && \
./install-perl-devtools.sh && \
./install-ruby-devtools.sh 