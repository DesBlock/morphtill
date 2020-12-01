#!/bin/bash
PARAMS=""
output=0
string="null"

while (( "$#" )); do
  case "$1" in
    -i|--in)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        in_file=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -o|--out)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        out_file=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

cmd="python morph-hta.py --in $in_file --out $out_file --maxvarlen 4 --maxstrlen 4"

while [ "$output" = 0 ]; do
    output=$($cmd | grep -c $string);
    echo "Not $string: " $(du -h $out_file) ;
done
