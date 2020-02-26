#!/bin/sh

# we need to make sure our path includes all the likely places to find Araxis
# command-line tools
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/Applications/Araxis\ Merge.app/Contents/Utilities:$PATH

#araxisgitmerge "$@"

# Use compare, because araxisgitmerge has problems with relative paths
# -wait is supposed to be default but clearly isn't
# Return value is wrong though (number of conflicts) so must do the same as araxisgitmerge
# and return 0 all the time (Sourcetree will check contents for conflicts)
compare -wait "$@"

exit 0

