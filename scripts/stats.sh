#!/bin/bash
# 
# Génération des données pour la page de statut
#

java -cp scripts/json.jar Main > ../code-story-status/data.json

cp ../code-story-status/scores-timeseries.json scores-timeseries.json
java -cp scripts/graph.jar codestory.GraphGenerator --onlyLast . < scores-timeseries.json > ../code-story-status/scores-timeseries.json
rm scores-timeseries.json

cd ../code-story-status
git add -A
git commit -am "MAJ"
git push origin gh-pages
