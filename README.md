[![docker-publish](https://github.com/Opendigitalradio/docker-dabmux/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/Opendigitalradio/docker-dabmux/actions/workflows/docker-publish.yml)

# opendigitalradio/docker-dabmux

## Introduction

This repository is part of a project aiming at containerizing the
[mmbTools](https://www.opendigitalradio.org/mmbtools) software stack of
[Open Digital Radio](https://www.opendigitalradio.org/). It features the
[dab multiplexer](https://github.com/opendigitalradio/ODR-DabMux) component.

You need to install [docker](https://www.docker.com) or
[podman](https://podman.io) on your host to run the container image.
Please adapt the instructions below, according to your choice.

## How to get the container image on your host

You can either pull the container image from the internet or build it
yourself.

### Pull the image from internet

```bash
docker image pull opendigitalradio/dabmux
```

### Build the image

```bash
git clone \
  https://github.com/opendigitalradio/docker-dabmux.git
cd docker-dabmux
docker buildx build --tag dabmux --output type=docker .
```

## Setup

1. Set your time zone:

    ```bash
    TZ=<your_time_zone>
    ```

1. Set your mux configuration file:

    ```bash
    MUX=<path_to_your_mux_configuration_file>
    ```

1. The image exposes the following ports:
    - 9001 - 9016: incoming encoder streams
    - 9201: output stream
    - 12720: multiplexer server management port
    - 12721: multiplexer ftp port
    - 12722: multiplexer ZMQ RC port

## Run the container

```bash
docker container run \
  --name odr-dabmux \
  --detach \
  --rm \
  --env "TZ=${TZ}" \
  --publish 9001-9016:9001-9016 \
  --publish 9201:9201 \
  --publish 12720-12722:12720-12722 \
  --volume ${MUX}:/config/odr-dabmux.inf \
  opendigitalradio/dabmux
```

## Test

You can verify the dab multiplex output stream by following these steps:

1. Ensure you installed wget and dablin packages on your host:
1. Run the command:

    ```bash
    nc HOST_RUNNING_CONTAINER 9201 | dablin_gtk -f edi -I -1
    ```
