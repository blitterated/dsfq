# Dockerized `sfq` SoundFont Compressor

## What It Is

Just [`sfq`](https://github.com/pahandav/sfq) running in a Docker container

## Building and Running

This image depends on the [`pyenv-dde`](https://github.com/blitterated/pyenv-dde) image.

### Build the image

```sh
docker build --progress=plain -t dsfq .
```

### Compress a soundfont file

```sh
docker run --rm -v "$(pwd):/soundfonts" dsfq some_soundfont.sf2
```

### Uncompress a soundfont file

```sh
docker run --rm -v "$(pwd):/soundfonts" dsfq some_soundfont.sfq
```

### Compress multiple soundfont files

```sh
docker run --rm -v "$(pwd):/soundfonts" dsfq '*.sf2'
```

### Uncompress multiple soundfont files

```sh
docker run --rm -v "$(pwd):/soundfonts" dsfq '*.sfq'
```

### Run a container with a shell

```sh
docker run -it --rm -v "$(pwd):/soundfonts" --entrypoint /bin/bash dsfq
```
