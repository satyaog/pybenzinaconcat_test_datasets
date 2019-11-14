#!/bin/bash

# this script is meant to be used with 'datalad run' 

function create_target {
  if [[ "$1" == "0000" ]] ; then
    printf '\x00\x00\x00\x00\x00\x00\x00\x00' > $1/$2.JPEG.target
  elif [[ "$1" == "0001" ]] ; then
    printf '\x01\x00\x00\x00\x00\x00\x00\x00' > $1/$2.JPEG.target
  elif [[ "$1" == "0002" ]] ; then
    printf '\x02\x00\x00\x00\x00\x00\x00\x00' > $1/$2.JPEG.target
  fi
}

create_target 0000 n02119789_4903
create_target 0000 n02119789_6970
create_target 0000 n02119789_11296

create_target 0001 n02100735_7054
create_target 0001 n02100735_7553
create_target 0001 n02100735_8211

create_target 0002 n02110185_679
create_target 0002 n02110185_2014
create_target 0002 n02110185_7939

git -c annex.largefiles=nothing add 0000/* 0001/* 0002/*
