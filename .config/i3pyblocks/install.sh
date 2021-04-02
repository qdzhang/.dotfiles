#!/bin/sh

python3 -m venv venv
source venv/bin/activate
python3 -m pip install 'i3pyblocks[blocks.inotify,blocks.ps,blocks.pulse]'
deactivate
