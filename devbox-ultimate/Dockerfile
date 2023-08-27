FROM ernst-fastl/devbox-helm

COPY /scripts/container/* .

RUN ./install_java_devtools.sh && \
./install_node_devtools.sh && \
./install_golang_devtools.sh  && \
./install_python_devtools.sh && \
./install_perl_devtools.sh && \
./install_ruby_devtools.sh 