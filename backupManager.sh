#!/bin/bash
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./backupManager /dir1/ /dir2/"
    echo "Usage: ./backupManager /dir1/ /dir2/ remote_host:/dir3/"
    exit 0
fi

currentDate=$(date +%Y-%m-%d_%H:%M)
outputDirName=$(basename $2)

outputName="${outputDirName}_${currentDate}.zip"
targetDir="${1}${outputName}"

zip -r $targetDir $2

if [ "$#" -eq 3 ]; then
    echo "Sending backup..."
    rsync $targetDir $3
fi