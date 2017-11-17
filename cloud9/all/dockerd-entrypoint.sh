#!/bin/sh
set -e

if [ "$#" -eq 0 ]; then
    set -- docker daemon \
        --host=unix:///var/run/docker.sock \
        --host=tcp://0.0.0.0:2375 \
        --registry-mirror=http://docker-cache.default:5001 \
        --mtu=1404 \
        --storage-driver=overlay \
        "$@"
fi

if [ "$1" = 'docker' -a "$2" = 'daemon' ]; then
    # if we're running Docker, let's pipe through dind
    # (and we'll run dind explicitly with "sh" since its shebang is /bin/bash)
    set -- sh "$(which dind)" "$@"
fi


nohup "$@" </dev/null >dind.log 2>&1 &
#exec "$@"
nodejs /cloud9/server.js -p 80 -w /workspace