#!/bin/bash

# this script is meant to be used with 'datalad run --explicit'

pip install -r scripts/requirements_concat.txt --upgrade
ERR_CODE=$?
if [ $ERR_CODE -ne 0 ]; then
   echo "Failed to install requirements: pip install: $ERR_CODE"
   exit $ERR_CODE
fi

python -m pyheifconcat.create_container concat.bzna
python -m pyheifconcat concat . concat.bzna

# Track deleted files
git add queue/
