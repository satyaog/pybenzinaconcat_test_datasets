#!/bin/bash

# this script is meant to be used with 'datalad run'

pip install -r scripts/requirements_transcode_scale_and_pad.txt --upgrade
if [ $? -ne 0 ]; then
   echo "Failed to install requirements: pip install: $?"
   return $?
fi

function scale_and_pad {
  python -m pyheifconcat.image2mp4 \
         --codec=h265 --tile=512:512:yuv420 --crf=10 \
         --output=$2.mp4 \
         --primary --thumb --name=$2.JPEG \
         --item=path=$1/$2.JPEG \
         --hidden --name=target --mime=application/octet-stream \
         --item=type=mime,path=$1/$2.JPEG.target
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

python -m pyheifconcat.image2mp4 \
       --codec=h265 --tile=512:512:yuv420 --crf=10 \
       --output=n02100735_8211_fake_no_target.mp4 \
       --primary --thumb --name=n02100735_8211_fake_no_target.JPEG \
       --item=path=no_target/n02100735_8211_fake_no_target.JPEG
