FROM alpine:3.4

RUN apk update && \
    apk add \ 
        alpine-sdk \
        bash \
        curl \
        git \
        nano \
        nodejs \
        py-pip \
        python \
        python3 \
        python-dev \
        subversion \
        tmux \
        vim \
        wget && \
    rm /usr/bin/vi && ln -s /usr/bin/vim /usr/bin/vi && \
    cd / && git clone https://github.com/krishnasrinivas/wetty.git && \
    cd wetty && npm install 

EXPOSE 3000

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["vim"]
