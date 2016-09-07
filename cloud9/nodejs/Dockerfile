FROM ndslabs/cloud9-base:latest

# Install NodeJS / NPM
RUN apt-get -qq update && \
    apt-get -qq install npm && \
    ln -s /usr/bin/nodejs /usr/bin/node

# Install Bower / Grunt / Gulp
RUN npm install -g bower grunt gulp
