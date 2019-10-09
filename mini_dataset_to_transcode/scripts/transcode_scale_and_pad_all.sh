#!/bin/bash

# this script is meant to be used with 'datalad run --explicit'

git rm -r --cached 000*
mkdir tmp
mv 000* tmp/

function scale_and_pad {
  if [[ "$1" == "0000" ]] ; then
    printf '\x00\x00\x00\x00\x00\x00\x00\x00' > tmp/$1/$2.JPEG.target
  elif [[ "$1" == "0001" ]] ; then
    printf '\x01\x00\x00\x00\x00\x00\x00\x00' > tmp/$1/$2.JPEG.target
  elif [[ "$1" == "0002" ]] ; then
    printf '\x02\x00\x00\x00\x00\x00\x00\x00' > tmp/$1/$2.JPEG.target
  fi

  python scripts/transcode_scale_and_pad.py \
         --codec=h265 --tile=512:512:yuv420 --crf=10 \
         --output=$2.mp4 \
         --primary --thumb --name=$2.JPEG \
         --item=path=tmp/$1/$2.JPEG \
         --hidden --name=target --mime=application/octet-stream \
         --item=type=mime,path=tmp/$1/$2.JPEG.target
}

scale_and_pad 0000 n02119789_4903
scale_and_pad 0000 n02119789_6970
scale_and_pad 0000 n02119789_11296

scale_and_pad 0001 n02100735_7054
scale_and_pad 0001 n02100735_7553
scale_and_pad 0001 n02100735_8211

scale_and_pad 0002 n02110185_679
scale_and_pad 0002 n02110185_2014
scale_and_pad 0002 n02110185_7939

rm -rf tmp
