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



# C++/C
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



# Python
RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      python-pip \
      python3-pip \
      vim && \
    pip install virtualenv  && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*



#PHP
WORKDIR /workspace
RUN apt-get -qq update && \
    apt-get -qq install \
      npm \
      php5 \
      php5-dev \
      php-pear \
      tmux \
      vim && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*
      
RUN pecl config-set php_ini /etc/php5/apache2/php.ini && \
    pecl install xdebug && \
    echo "zend_extension=\"/usr/lib/php5/20131226/xdebug.so\"" > /etc/php5/mods-available/xdebug.ini && \
    php5enmod xdebug




#GO

ARG go_version=1.6

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	bison \
	gdb \
	gdbserver \
	wget \
	vim-gnome && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN curl -fsSL "https://golang.org/dl/go${go_version}.linux-amd64.tar.gz" -o /tmp/golang.tar.gz && \
    mkdir -p /usr/local/go/${version} && \
    tar -C /usr/local/go/${version} --strip-components=1 -xzf /tmp/golang.tar.gz && \
    rm /tmp/golang.tar.gz && \
    update-alternatives --install /usr/bin/go go /usr/local/go/${version}/bin/go 1 && \
    update-alternatives --install /usr/bin/godoc godoc /usr/local/go/${version}/bin/godoc 1 && \
    update-alternatives --install /usr/bin/gofmt gofmt /usr/local/go/${version}/bin/gofmt 1 

ENV GOROOT /usr/local/go/${version}

ENV GOPATH /gotools
RUN go get github.com/tools/godep && \
    go get github.com/nsf/gocode 

ENV GOPATH /workspace
ENV PATH /workspace/bin:/gotools/bin:$PATH

COPY .vimrc /root/.vimrc

RUN mkdir -p /root/.vim/colors && \
    git clone git://github.com/altercation/vim-colors-solarized.git /tmp/vim-solarized && \
    mv /tmp/vim-solarized/colors/solarized.vim /root/.vim/colors && \
    git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim && \
    rm -rf /root/.vim/bundle/Vundle.vim/.git /tmp/vim-solarized/.git

RUN vim  +PluginInstall +qall 








#DOCKER
USER root
RUN apt-get -qq update && \
    apt-get -qq install \
        ca-certificates \
        curl \
        wget \
        openssl \
#        btrfs-progs \
        e2fsprogs \
#        e2fsprogs-extra \
        iptables \
#        xz \
        xfsprogs && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.6
ENV DOCKER_SHA256 cadc6025c841e034506703a06cf54204e51d0cadfae4bae62628ac648d82efdd

RUN set -x \
    && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v

RUN set -x \
    && sh -c 'addgroup --system dockremap' \
    && sh -c 'adduser --system --ingroup dockremap dockremap' \
    && sh -c 'echo dockremap:165536:65536 > /etc/subuid' \
    && sh -c 'echo dockremap:165536:65536 > /etc/subgid'

ENV DIND_COMMIT 3b5fac462d21ca164b3778647420016315289034

RUN wget "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" -O /usr/local/bin/dind \
    && chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []