FROM craigwillis/cloud9-base

#USER root
#RUN useradd developer -c "NodeJS Developer"

# Install NodeJS / NPM / Bower / Grunt.js / Gulp.js
RUN apt-get -qq update && \
    apt-get -qq install npm && \
    npm install -g bower grunt gulp && \
    ln -s /usr/bin/nodejs /usr/bin/node

#USER developer
