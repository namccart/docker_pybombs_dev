FROM ubuntu:15.10

RUN apt-get update && \
    apt-get -y install python-pip \
    git \
    sudo && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/gnuradio/pybombs.git && \
    cd /pybombs && \
    python setup.py install


COPY config_packages.yml /

RUN apt-get update && \
    pybombs recipes add gr-recipes git+https://github.com/namccart/gr-recipes.git && \
    pybombs prefix init /gnuradio-prefix -a target && \
    cat /config_packages.yml >> ~/.pybombs/config.yml && \
    pybombs -p target install gnuradio && \
    pybombs -p target deploy -j --keep-config --keep-src target.tar.bz2 && \
    rm -rf /gnuradio-prefix && \
    rm -rf /var/lib/apt/lists/*
