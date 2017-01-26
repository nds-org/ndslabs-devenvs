FROM ndslabs/cloud9-base:latest

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

