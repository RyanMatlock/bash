#!/bin/bash

# this script is designed to make it easier to install LaTeX packages and
# scripts to $TEXMFHOME/tex/latex

cp "$1" $(kpsewhich -var-value=TEXMFHOME)/tex/latex
