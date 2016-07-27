#!/bin/bash

#xpra start --auth=password:value=${XPRA_PASSWORD} --daemon=no --exit-with-children --mdns=no --pulseaudio=no --printing=no --webcam=no  --bind-tcp=0.0.0.0:10000 --html=on --start-child=/pycharm-community-2016.2/bin/pycharm.sh
xpra start --daemon=no --exit-with-children --mdns=no --pulseaudio=no --printing=no --webcam=no  --bind-tcp=0.0.0.0:10000 --html=on --start-child=/pycharm-community-2016.2/bin/pycharm.sh
