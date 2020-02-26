#!/bin/sh

# we need to make sure our path includes all the likely places to find Araxis
# command-line tools
# The Araxis Merge folder is put before /usr/local/bin because an old version of
# Araxis Merge no longer works, but the user might've previously installed it so
# we ensure it's in there first
export PATH=~/bin:/Applications/Araxis\ Merge.app/Contents/Utilities:/usr/local/bin:/usr/bin:/bin:$PATH

compare "$@"
