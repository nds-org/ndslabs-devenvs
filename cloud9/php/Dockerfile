FROM ndslabs/cloud9-base:latest

WORKDIR /workspace
RUN apt-get -qq update && \
    apt-get -qq install \
      npm \
      php5 \
      php5-dev \
      php-pear \
      tmux \
      vim && \
    apt-get -y clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/*
      
RUN pecl config-set php_ini /etc/php5/apache2/php.ini && \
    pecl install xdebug && \
    echo "zend_extension=\"/usr/lib/php5/20131226/xdebug.so\"" > /etc/php5/mods-available/xdebug.ini && \
    php5enmod xdebug
