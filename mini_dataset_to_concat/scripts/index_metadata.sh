#!/bin/bash

# this script is meant to be used with 'datalad run --explicit'

pip install -r scripts/requirements_index_metadata.txt --upgrade
ERR_CODE=$?
if [ $ERR_CODE -ne 0 ]; then
   echo "Failed to install requirements: pip install: $ERR_CODE"
   exit $ERR_CODE
fi

[ -f concat_indexed.bzna ] || cp concat.bzna concat_indexed.bzna

python -m pyheifconcat.index_metadata concat_indexed.bzna
