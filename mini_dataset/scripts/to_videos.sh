#!/bin/bash

# this script is meant to be used with 'datalad run'

ffmpeg -framerate 1 -i 'n02119789_4903_pad.JPEG' -c:v libx265 -tag:v hvc1 -pix_fmt yuv420p -crf 10 n02119789_4903_pad.mp4
ffmpeg -framerate 1 -i 'n02119789_6970_pad.JPEG' -c:v libx265 -tag:v hvc1 -pix_fmt yuv420p -crf 10 n02119789_6970_pad.mp4
ffmpeg -framerate 1 -i 'n02119789_11296_pad.JPEG' -c:v libx265 -tag:v hvc1 -pix_fmt yuv420p -crf 10 n02119789_11296_pad.mp4

git rm *.JPEG
