#!/bin/bash

# this script is meant to be used with 'datalad run'

ffmpeg -y -i n02119789_4903.JPEG -vf "pad=512:512:0:0,fillborders=0:12:0:179:smear" n02119789_4903_pad.JPEG
ffmpeg -y -i n02119789_6970.JPEG -vf "pad=512:512:0:0,fillborders=0:12:0:72:smear" n02119789_6970_pad.JPEG
ffmpeg -y -i n02119789_11296.JPEG -vf "pad=512:512:0:0,fillborders=0:12:0:137:smear" n02119789_11296_pad.JPEG

git rm n02119789_4903.JPEG n02119789_6970.JPEG n02119789_11296.JPEG
