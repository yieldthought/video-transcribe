#!/bin/bash

set -e

VIDEO="$1"
TXT="$2"

if [ "$1" == "--help" ] || [ "$2" == "" ]; then
    echo "Usage: $0 VIDEO_FILE TRANSCRIPT_FILE"
    echo "Generates an index.html and runs http-server in the current directory"
    echo "View the page to watch your video and navigate with the transcript"
    echo "Run ./transcribe.sh to generate a transcript first."
    exit 1
fi

sed s:VIDEO_NAME:${VIDEO}:g template.html > ~tmp
sed s:TXT_NAME:${TXT}:g ~tmp > index.html
rm ~tmp

http-server
