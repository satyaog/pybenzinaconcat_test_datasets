#!/bin/bash

# this script is meant to be used with 'datalad run --explicit'

mkdir tmp
mv *.mp4 tmp/

python scripts/tune_video.py tmp/n02119789_4903_pad.mp4 n02119789_4903_pad.mp4 500 333
python scripts/tune_video.py tmp/n02119789_6970_pad.mp4 n02119789_6970_pad.mp4 500 440
python scripts/tune_video.py tmp/n02119789_11296_pad.mp4 n02119789_11296_pad.mp4 500 375

rm -rf tmp
