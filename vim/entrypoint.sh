#!/bin/sh
set -e


if [ "$1" = "vim" ]; then
   adduser -h /home/$NAMESPACE -s /bin/bash -G root -D -H $NAMESPACE
   mkdir -p /home/$NAMESPACE

   cd /wetty 
   sed -i "106s?^.*?term = pty.spawn('/bin/su', ['-', '$NAMESPACE'], {?" app.js
   node app.js -p 3000 
else 
   exec "$@"
fi
