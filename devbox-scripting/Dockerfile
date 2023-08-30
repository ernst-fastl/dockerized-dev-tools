FROM efastl/devbox-helm

COPY /scripts/container/* .

RUN ./install_node_devtools.sh && \
./install_python_devtools.sh && \
./install_powershell_devtools.sh && \
./install_perl_devtools.sh && \
./install_ruby_devtools.sh