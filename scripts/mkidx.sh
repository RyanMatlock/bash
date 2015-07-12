#!/bin/bash

# this script makes it easier to generate the index for LaTeX dtx files (and
# probably regular LaTeX files, too)

arg1="$1"
dir=$(dirname $arg1)
filename=$(basename $arg1)
cd $dir
pdflatex $filename
filename="${filename%.*}" # extract everything before the extension
makeindex -s gind.ist $filename
makeindex -s gglo.ist -o $filename.gls $filename.glo
filename="$filename.dtx"
pdflatex $filename
pdflatex $filename
cd - > /dev/null # have to do this to supress output
