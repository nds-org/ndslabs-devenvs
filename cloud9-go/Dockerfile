FROM ubuntu:wily

RUN apt-get update
RUN apt-get install -y \
	build-essential \
	curl \
	gdb \
	gdbserver \
	git \
	golang \
	lsof \
	nodejs \
	python \
	vim


RUN git clone https://github.com/c9/core.git /cloud9
WORKDIR /cloud9
RUN scripts/install-sdk.sh

RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 

RUN mkdir /workspace
VOLUME /workspace
ENV GOPATH /workspace
ENV PATH /usr/local/go/bin:$PATH

EXPOSE 80
EXPOSE 15475
EXPOSE 15476

CMD ["nodejs", "/cloud9/server.js", "-p", "80", "-w", "/workspace"]
