# Ubuntu Development Environment

This Dockerfile creates an Ubuntu-based development environment with a variety of useful tools and packages 
pre-installed. The resulting image can be used as a base for building and running development environments for a 
variety of projects.

## Usage

To use this Dockerfile, simply build the image using the `docker build` command:

``` bash
docker build -t ubuntu-devbox-base .
```

Once the image has been built, you can run a container using the `docker run` command:

``` bash
docker run -it ubuntu-devbox-base .
```

This will start a container running the Ubuntu development environment, with a bash shell as the default entrypoint.

## Included Packages

In this Dockerfile, we utilize the `unminimize` command to convert a minimal Ubuntu system into a standard system by 
installing various essential packages typically found in the standard Ubuntu installation. This process ensures that 
the image includes common utilities and tools, enhancing its usability and compatibility.

We also aditionally install some generally useful packages. Read the Dockerfile for the current list of those packages.

## Customization

This Dockerfile can be customized to include additional packages or tools as needed. Simply modify the `RUN` command that installs the packages to include any additional packages you require.

## License

This Dockerfile is released under the MIT License. See the [LICENSE](LICENSE) file for details.