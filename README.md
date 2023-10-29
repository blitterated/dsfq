# Dockerized `sfq` SoundFont Compressor

## What It Is

Just [`sfq`](https://github.com/pahandav/sfq) running in a Docker container

## Building and Running

This image depends on the [`dirty-little-dev`](https://github.com/blitterated/dirty-little-dev) image.

### Build the image

```sh
docker build -t dsfq .
```

### Run a container

```sh
docker run --rm dsfq
```

### Run a container with a shell

```sh
docker run -it --rm --entrypoint /bin/bash dsfq
```
