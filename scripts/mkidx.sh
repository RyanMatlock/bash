#!/bin/bash

arg1="$1"
dir=$(dirname $arg1)
filename=$(basename $arg1)
# echo $dir
cd $dir
# pwd
echo $filename
filename="${filename%.*}"
echo $filename
cd - > /dev/null # have to do this to supress output

# pdflatex yahw.dtx
# makeindex -s gind.ist yahw
