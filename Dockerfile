FROM ndslabs/cloud9-base:latest

ARG version=8

# Install some common dependencies
RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      curl \
      unzip \
      python-software-properties \
      software-properties-common \
      maven \
      ant && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*


RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      npm && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Then install the JDK
RUN apt-get -qq update && \
    apt-get -qq install \
      openjdk-${version}-jdk && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Install Bower / Grunt / Gulp
RUN npm install -g bower grunt gulp



#Rails Portion
ARG ruby_version=2.4.1
ARG rails_version=5.1.2

# Install dependencies
RUN apt-get -qq update && \
    apt-get -qq install \
      gawk \
      libxml2-dev \
      libxslt-dev \
      libgdbm-dev \
      libgmp-dev \
      sqlite3 \
      sudo && \
    apt-get -qq clean all && \
    apt-get -qq autoclean && \
    apt-get -qq autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install RVM
RUN bash -l -c "curl -sSL https://get.rvm.io | sudo bash -s stable --autolibs=enabled"

# Install Rails
RUN bash -l -c "rvm install ruby-${ruby_version} && \
    rvm use ${ruby_version}@rails5 --create --default && \
    NOKOGIRI_USE_SYSTEM_LIBRARIES=1 gem install rails -v ${rails_version}"

RUN bash -l -c "ls -al /root/ && echo $PATH && rvm -v && \
    ruby -v && \
    gem -v && \
    gem environment && \
    rails -v"

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