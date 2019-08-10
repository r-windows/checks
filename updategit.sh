#!/bin/sh
./summary.sh
rm *.tar.gz
git rm -rf --cached .
git add $(find . -maxdepth 1 -type f)
git add -f $(grep "ERROR:" */00install.out | cut -d: -f1)
git add -f $(grep "Status: [0-9] ERROR" */00check.log | cut -d: -f1)
git add -f $(grep "Status: [0-9] WARNING" */00check.log | cut -d: -f1)
git status
read -p "Commit and push these changes? (y/n)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
git commit -m "Update at $(date)"
git push
fi

