#!/bin/bash
# 
# Recapitulatifs des participants et de leurs reponses
#

./scripts/logins.sh | xargs -I {} ./scripts/info.sh {} | column -t -s ";" | sort -f
