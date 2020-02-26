#!/bin/sh

# gitbranchesbydate.sh
# Sourcetree
#
# Created by Steven Streeting on 20/03/2011.
# Copyright 2011 Atlassian. All rights reserved.

for k in `git branch|sed s/^..//`;do echo -e `git log -1 --format="%ci" "$k"`\\t"$k";done|sort -r
