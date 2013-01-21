#!/bin/bash
# 
# Envoi des requetes aux participants
#

java -cp scripts/json.jar Main > ./code-story-status/data.json
cd ../code-story-status
git add -A
git commit -am "MAJ"
git push origin gh-pages
