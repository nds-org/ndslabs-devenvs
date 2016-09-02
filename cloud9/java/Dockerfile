FROM ndslabs/cloud9-base

RUN apt-get -qq update && \
    apt-get -qq install \
      curl \
      unzip \
      python-software-properties \
      software-properties-common \
      maven \
      ant && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/*  
