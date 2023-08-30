FROM efastl/ubuntu-base

COPY /devbox-base/entrypoint.sh /entrypoint.sh

COPY /scripts/container/* .

RUN mkdir -p /workspace

RUN ./install_devbox_base_packages.sh

ENTRYPOINT [ "/entrypoint.sh" ]