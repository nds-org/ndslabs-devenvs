FROM ndslabs/cloud9-base:latest

RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      python-pip \
      python3-pip \
      vim && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*
