#!/bin/bash

./scripts/foreach.sh type
./scripts/foreach.sh email
./scripts/foreach.sh mailing
./scripts/foreach.sh mood
./scripts/foreach.sh post-ready

./scripts/recap.sh
