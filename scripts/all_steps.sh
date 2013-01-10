#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

STEPS=$(./scripts/steps.sh)
for STEP in $STEPS; do
	SCRIPT=./scripts/steps/$STEP.sh
	$SCRIPT $LOGIN
done