#!/bin/bash

set -e

VIDEO="$1"
TXT="$2"

if [ "$1" == "--help" ] || [ "$1" == "" ]; then
    echo "Usage: $0 VIDEO_FILE [TRANSCRIPT_FILE]"
    echo "Generates an index.html and runs http-server in the current directory"
    echo "View the page to watch your video and navigate with the transcript"
    echo "Transcript uses VIDEO_FILE.srt if this exists."
    echo "Run ./transcribe.sh to generate a transcript first."
    exit 1
fi

if [ -z "$TXT" ] && [ -f "${VIDEO}.srt" ]; then
    TXT="${VIDEO}.srt"
fi

if [ -z "$TXT" ]; then
    echo "Error: TRANSCRIPT_FILE not specified and ${VIDEO}.srt does not exist."
    exit 1
fi

SCRIPT_DIR=$(dirname "$0")
TEMPLATE_FILE="${SCRIPT_DIR}/template.html"
TEMP_FILE=$(mktemp)

sed "s:VIDEO_NAME:${VIDEO}:g" "$TEMPLATE_FILE" > ${TEMP_FILE}
sed s:TXT_NAME:${TXT}:g ${TEMP_FILE} > index.html
rm ${TEMP_FILE}

http-server
