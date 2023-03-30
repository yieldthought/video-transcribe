#!/bin/bash

usage() {
  echo "Usage: $0 [-h] [-m model] input_file output_file"
  echo "Transcribe an audio file with timestamps using whisper.cpp"
  echo ""
  echo "Options:"
  echo "  -h, --help     show this help message and exit"
  echo "  -m model       name of the whisper.cpp model to use (default: medium.en)"
  echo "  input_file     path to input audio file"
  echo "  output_file    path to output SRT file"
}

model="medium.en"

# Parse command-line arguments
while getopts "hm:" opt; do
  case "$opt" in
    h) usage; exit 0;;
    m) model="$OPTARG";;
    \?) usage >&2; exit 1;;
  esac
done

# Shift the options so that $1 now refers to the input file and $2 to the output file.
shift $((OPTIND-1))
input_file="$1"
output_file="$2"

# Make sure that both input and output files are specified
if [[ -z $input_file || -z $output_file ]]; then
  usage >&2
  exit 1
fi

# Transcribe audio with whisper.cpp
whisper --model "$model" --task transcribe --language en "$input_file" > "$output_file"

