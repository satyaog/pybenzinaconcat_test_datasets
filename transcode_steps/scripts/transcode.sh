#!/bin/bash

# this script is meant to be used with 'datalad run'

ffmpeg -y -framerate 1 -i 0000/n02119789_4903.JPEG -filter_complex \
"[0:0]pad=512:512:0:0,fillborders=0:12:0:179:smear[i]" \
-map [i] \
-c:v libx265 -tag:v hvc1 -pix_fmt yuv420p -crf 10 \
n02119789_4903.mp4

ffmpeg -y -framerate 1 -i 0001/n02100735_8211.JPEG -filter_complex \
"[0:0]pad=1024:1024:0:0,fillborders=0:424:0:489:smear[i]; \
[0:0]scale=w=512:h=456,pad=512:512:0:0,fillborders=0:0:0:56:smear[t]" \
-map [i] -map [t] \
-c:v libx265 -tag:v hvc1 -pix_fmt yuv420p -crf 10 \
n02100735_8211.mp4
