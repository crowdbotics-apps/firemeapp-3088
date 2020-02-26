#!/bin/sh

# hg-merge.sh
# Sourcetree
#
# Created by Steven Streeting on 23/01/2011.
# Copyright 2011 Atlassian. All rights reserved.

# this is used if premerge fails
# mostly this is to avoid hg merge just failing on binary file conflicts

# in fact, we use this for non-binary files too so that we can have a 'merge tool'
# which deals with both creating chevron conflicts in text files, and leaving
# binary files alone.

# "$1" == mine
# "$2" == base
# "$3" == theirs

# This is already in the right order for merge

# Don't try to call merge for binaries, does weird things
textFile=`file "$1" | grep text`
if [[ "$textFile" == "" ]]
then
	false
else
	curdir=`dirname $0`
	$curdir/merge -L mine -L base -L theirs "$@"
fi
