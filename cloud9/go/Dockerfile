FROM ndslabs/cloud9-base:latest

ARG version=1.6

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	bison \
	gdb \
	gdbserver \
	wget \
	vim-gnome && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN curl -fsSL "https://golang.org/dl/go${version}.linux-amd64.tar.gz" -o /tmp/golang.tar.gz && \
    mkdir -p /usr/local/go/${version} && \
    tar -C /usr/local/go/${version} --strip-components=1 -xzf /tmp/golang.tar.gz && \
    rm /tmp/golang.tar.gz

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
