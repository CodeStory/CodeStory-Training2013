#!/bin/bash

ruby -e 'Dir["scripts/steps/*"].map {|x| File.basename(x).chomp(".sh")}.sort.each {|x| puts(x)}'
