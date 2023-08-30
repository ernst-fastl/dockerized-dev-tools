FROM efastl/devbox-scripting

COPY /scripts/container/* .

# these will be very large layers each, so we choose to keep them separate

RUN ./install_java_devtools.sh 

RUN ./install_golang_devtools.sh 

RUN ./install_dotnet_devtools.sh