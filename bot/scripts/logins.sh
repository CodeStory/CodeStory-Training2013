#!/bin/bash

ruby -e 'Dir["logins/*"].each{|x| puts File.basename(x)}'