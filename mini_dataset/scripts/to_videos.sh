#!/bin/bash

# this script is meant to be used with 'datalad run'

ffmpeg -framerate 1 -i 'n02119789_4903_pad.JPEG' -c:v libx264 -crf 10 -pix_fmt yuv420p n02119789_4903_pad.mp4
ffmpeg -framerate 1 -i 'n02119789_6970_pad.JPEG' -c:v libx264 -crf 10 -pix_fmt yuv420p n02119789_6970_pad.mp4
ffmpeg -framerate 1 -i 'n02119789_11296_pad.JPEG' -c:v libx264 -crf 10 -pix_fmt yuv420p n02119789_11296_pad.mp4

git rm *.JPEG
