#!/bin/sh

python3 -m venv venv
source venv/bin/activate
python3 -m pip install 'i3pyblocks[blocks.inotify,blocks.i3ipc,blocks.ps,blocks.pulse]'
deactivate
