#!/bin/bash

# this script is meant to be used with 'datalad run'

pip install -r scripts/requirements_fix_trak_name.txt --upgrade
if [ $? -ne 0 ]; then
   echo "Failed to install requirements: pip install: $?"
   return $?
fi

# CURRENT_COMMIT=$(git rev-parse HEAD)
# git-annex direct --fast

for file in *.mp4; do
    python scripts/fix_trak_name.py $file
done

# git-annex indirect --fast
# git reset $CURRENT_COMMIT
