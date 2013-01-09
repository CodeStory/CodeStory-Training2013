#!/bin/bash
# 
# Envoi des requetes aux participants
#

./scripts/logins.sh | parallel ./scripts/all_steps.sh {}
./recap.sh
