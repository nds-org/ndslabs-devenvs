FROM craigwillis/cloud9-base

# Install NodeJS / NPM / Bower / Grunt.js / Gulp.js
RUN apt-get -qq update && \
    apt-get -qq install npm && \
    npm install -g bower grunt gulp && \
    ln -s /usr/bin/nodejs /usr/bin/node
