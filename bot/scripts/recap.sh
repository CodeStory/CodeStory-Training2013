#!/bin/bash

./scripts/foreach.sh info | column -t -s ";" | sort -f