FROM ndslabs/novnc-base:latest

RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      python-pip \
      python-dev \
      build-essential && \
    pip install --upgrade pip && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN cd / && \
   wget -q http://download.jetbrains.com/python/pycharm-community-2016.2.tar.gz && \
   tar xvfz pycharm-community-2016.2.tar.gz &&  \
   rm pycharm-community-2016.2.tar.gz

ADD init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 80

CMD ["/init.sh"]

