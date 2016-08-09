FROM ubuntu:xenial

RUN apt-get update -y && \
	apt-get -y install \
	curl \
	git \
	net-tools \
	python \
	python-numpy \
	python-pkg-resources \
	vim \
	websockify \
	wget \
	xdotool \
	xfonts-base \
	x11-utils \
	x11vnc \
	xvfb 

ENV DISPLAY=:0

RUN cd / && git clone git://github.com/kanaka/noVNC 

ADD index.html /noVNC/
ADD init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 80

CMD ["/init.sh"]

