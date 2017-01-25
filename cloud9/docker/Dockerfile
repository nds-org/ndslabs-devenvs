FROM ndslabs/cloud9-base:latest

COPY ./entrypoint.sh /

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	docker.io \
	iptables \
	wget && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.6
ENV DIND_COMMIT 3b5fac462d21ca164b3778647420016315289034



RUN set -x \
    && cd / \
    && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    && tar -xzvf docker.tgz \
    && rm docker.tgz \
    && docker -v \
    && wget "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" -O /usr/local/bin/dind \
    && chmod +x /usr/local/bin/dind

ENTRYPOINT ["/entrypoint.sh"]
CMD ["docker"]
