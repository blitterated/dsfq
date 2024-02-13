# Test scripts and utilities

### Testing visibility of arguments and environment variables

This tripped me up a bit, so I needed some quick and dirty scripts to debug with.

`sh-env-args` and `py-env-args` both list out the following:

* Environment Variable names and values
* `PATH` directories broken out by line
* All arguments passed into container via `$@`

Add the following lines to the `Dockerfile` to add them to the container

```Dockerfile
COPY test/py-env-args $SFQ_DIR/py-env-args
COPY test/sh-env-args $SFQ_DIR/sh-env-args
```

Use this `ENTRYPOINT` to check that the initial shell can see ENV VARS and ARGS

```Dockerfile
ENTRYPOINT ["/bin/bash", "-l", "-c", "exec sh-env-args \"$@\""]
```

Use this `ENTRYPOINT` to check that `python` can see ENV VARS and ARGS

```Dockerfile
ENTRYPOINT ["/bin/bash", "-l", "-c", "exec py-env-args \"$@\""]
```
