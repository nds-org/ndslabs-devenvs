FROM ndslabs/cloud9-base:latest


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


RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ARG java_version=8

# Then install the JDK
RUN apt-get -qq update && \
    apt-get -qq install \
      openjdk-${java_version}-jdk && \
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
RUN curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import - && \
    bash -l -c "curl -sSL https://get.rvm.io | sudo bash -s stable --autolibs=enabled"

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
      build-essential && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*



# Python
RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      python-pip \
      python3-pip \
      vim && \
    pip install --upgrade pip && \
    pip install virtualenv  && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*



#PHP
WORKDIR /workspace
RUN apt-get -qq update && \
    apt-get -qq --no-install-recommends install \
      php \
      php-fpm && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*
 

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

# NOTE: no tty here, so we pipe to /dev/null
# The "echo" pipes are just there to send a newline in case the process prompts for input
RUN bash -c "echo | echo | vim +PluginInstall +qall &>/dev/null"
