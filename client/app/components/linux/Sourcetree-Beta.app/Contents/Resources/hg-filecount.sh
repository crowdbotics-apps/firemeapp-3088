#!/bin/sh

# hg-filecount.sh
# Sourcetree
#
# Created by Brian Ganninger on 15/11/2018.
# Copyright 2018 Atlassian. All rights reserved.

hg manifest --rev tip | wc -l
