FROM ndslabs/cloud9-base:latest

RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      gcc \
      g++ \
      gdb \
      gdbserver \
      build-essential \
      vim && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*
