FROM ubuntu:xenial

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-4.3.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENV PATH /opt/conda/bin:$PATH

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

# Install Git / NodeJS / NPM
RUN apt-get -qq update && \
    apt-get -qq install \
      git \
      ca-certificates \
      curl \
      lsof \
      python \
      build-essential \
      nodejs \
      npm && \
    apt-get -qq autoremove && \
    apt-get -qq autoclean && \
    apt-get -qq clean all && \
    rm -rf /var/cache/apk/*

# Fix nodejs installation
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Install Cloud9
RUN git clone --depth 1 --single-branch https://github.com/c9/core.git /cloud9
WORKDIR /cloud9
RUN scripts/install-sdk.sh

RUN C9_DIR=$HOME/.c9 && PATH="$C9_DIR/node/bin/:$C9_DIR/node_modules/.bin:$PATH" && cd $C9_DIR && npm install pty.js
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 

RUN mkdir /workspace
VOLUME /workspace

EXPOSE 80

CMD ["nodejs", "/cloud9/server.js", "-p", "80", "-w", "/workspace", "-a", ":", "--listen", "0.0.0.0" ]

