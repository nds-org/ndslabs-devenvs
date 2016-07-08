FROM ndslabs/cloud9-base:latest

RUN apt-get install -y \
	bison \
	gdb \
	gdbserver \
	wget \
	vim-gnome

RUN curl -fsSL "https://golang.org/dl/go1.4.3.linux-amd64.tar.gz" -o /tmp/golang.tar.gz \
    && mkdir -p /usr/local/go/1.4.3  \
	&& tar -C /usr/local/go/1.4.3 --strip-components=1 -xzf /tmp/golang.tar.gz \
	&& rm /tmp/golang.tar.gz \
    && update-alternatives --install /usr/bin/go go /usr/local/go/1.4.3/bin/go 1 \
    && update-alternatives --install /usr/bin/godoc godoc /usr/local/go/1.4.3/bin/godoc 1 \
    && update-alternatives --install /usr/bin/gofmt gofmt /usr/local/go/1.4.3/bin/gofmt 1 

RUN curl -fsSL "https://golang.org/dl/go1.5.linux-amd64.tar.gz" -o /tmp/golang.tar.gz \
    && mkdir -p /usr/local/go/1.5  \
	&& tar -C /usr/local/go/1.5 --strip-components=1 -xzf /tmp/golang.tar.gz \
	&& rm /tmp/golang.tar.gz \
    && update-alternatives --install /usr/bin/go go /usr/local/go/1.5/bin/go 2 \
    && update-alternatives --install /usr/bin/godoc godoc /usr/local/go/1.5/bin/godoc 2 \
    && update-alternatives --install /usr/bin/gofmt gofmt /usr/local/go/1.5/bin/gofmt 2 

RUN curl -fsSL "https://golang.org/dl/go1.6.linux-amd64.tar.gz" -o /tmp/golang.tar.gz \
    && mkdir -p /usr/local/go/1.6  \
	&& tar -C /usr/local/go/1.6 --strip-components=1 -xzf /tmp/golang.tar.gz \
	&& rm /tmp/golang.tar.gz \
    && update-alternatives --install /usr/bin/go go /usr/local/go/1.6/bin/go 3 \
    && update-alternatives --install /usr/bin/godoc godoc /usr/local/go/1.6/bin/godoc 3 \
    && update-alternatives --install /usr/bin/gofmt gofmt /usr/local/go/1.6/bin/gofmt 3 


ENV PATH /workspace/bin:$PATH
ENV GOPATH /workspace
ENV GOROOT /usr/local/go/1.6


COPY .vimrc /root/.vimrc

RUN mkdir -p /root/.vim/colors && \
    rm -r /tmp/vim-solarized && \
    rm -r /root/.vim/bundle/Vundle.vim && \
    git clone git://github.com/altercation/vim-colors-solarized.git /tmp/vim-solarized && \
	mv /tmp/vim-solarized/colors/solarized.vim /root/.vim/colors && \
    git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim 


RUN vim  +PluginInstall +qall 
RUN go get github.com/tools/godep 
