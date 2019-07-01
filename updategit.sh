#!/bin/sh
./summary.sh
rm *.tar.gz
git rm -rf --cached .
git add $(find . -maxdepth 1 -type f)
git add $(grep "ERROR:" */00install.out | cut -d: -f1)
git add $(grep "Status: [0-9] ERROR" */00check.log | cut -d: -f1)
git add $(grep "Status: [0-9] WARNING" */00check.log | cut -d: -f1)
git commit -m "Update at $(date)"
