FROM ndslabs/xpra-base:latest

RUN yum update -q -y && \
    yum install -y python-pip 


# install PyCharm
RUN cd / && \
    wget -q http://download.jetbrains.com/python/pycharm-community-2016.2.tar.gz && \
    tar xvfz pycharm-community-2016.2.tar.gz && \ 
    rm pycharm-community-2016.2.tar.gz 

COPY entrypoint.sh /

CMD [ "/entrypoint.sh"]


