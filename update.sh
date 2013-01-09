#!/bin/bash
# 
# Envoi des requetes aux participants
#

./scripts/logins.sh | xargs -P 8 -I {} ./scripts/all_steps.sh {}
./recap.sh
