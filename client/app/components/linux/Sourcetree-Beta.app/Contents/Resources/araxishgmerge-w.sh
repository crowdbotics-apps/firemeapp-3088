#!/bin/sh

# we need to make sure our path includes all the likely places to find Araxis
# command-line tools
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/Applications/Araxis\ Merge.app/Contents/Utilities:$PATH

araxishgmerge "$@"

