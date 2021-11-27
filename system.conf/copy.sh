#!/bin/bash
# https://www.laggner.at/config-file-backup-with-git/

find . -maxdepth 1 -mindepth 1 ! -regex "./\(config_files.txt\|copy.sh\|README.md\)" | xargs rm –r
cat config_files.txt | xargs -I {} rsync -rR {} .
