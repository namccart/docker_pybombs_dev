#Sample Build Command:

```
docker build -t namccart/pybombs-dev .
```

pybombs-dev uses the pybombs deploy command to package a reasonably-sized gnuradio install into a docker image.  Of course, once you inflate the tar file, your image will no longer be of reasonable size (arguably, it's too big as-is).

If you want to distribute an application on top of this image through docker, you'll probably want to untar, pybombs install, and then re-tar using pybombs deploy, all within the same docker run command.  Locally, users can untar by placing this stanza atop a Dockerfile:

```
FROM namccart/pybombs-dev
RUN tar xvfj /target.tar.bz2 && \
```

docker will use the same intermediate layer for any Dockerfile starting this stanza, so you can untar just once.