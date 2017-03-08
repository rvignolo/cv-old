#!/bin/bash 

function callinkscape {                                                                                                                             
 inkscape -z $1 --export-area-page --export-text-to-path --export-pdf=`basename $1 .svg`.pdf
#  inkscape -z $1 --export-area-page --export-dpi=203.25 --export-png=`basename $1 .svg`.png
}

if [ -z `which inkscape` ]; then
 echo "error: inkscape not installed"
 exit 1
fi

if [ -z "$1" ]; then
  for i in *.svg; do
    echo $i
    callinkscape $i
  done
else
  callinkscape $1
fi
