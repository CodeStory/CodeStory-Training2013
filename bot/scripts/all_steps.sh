#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

#STEPS=$(ruby -e 'Dir["scripts/steps/*"].map {|x| File.basename(x).chomp(".sh")}.sort.each {|x| puts(x)}')
STEPS=$(ruby -e 'Dir["scripts/steps/*"].map {|x| File.basename(x)}.sort.each {|x| puts(x)}')
for STEP in $STEPS; do
	SCRIPT=./scripts/steps/$STEP
	$SCRIPT $LOGIN
done