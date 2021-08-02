#/usr/bin/env bash

if [[ ! $(pgrep -u $UID -x clipcatd) ]]; then
    clipcatd &
else
    killall clipcatd
    sleep 2
    clipcatd &
fi
