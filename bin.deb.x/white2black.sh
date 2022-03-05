#!/bin/bash

convert $1 -negate -modulate 100,100,0 ${1%.*}_invert.png

