#!/bin/sh

#  find-gpg.sh
#  Sourcetree
#
#  Created by Kieran Senior on 12/08/2013.
#  Copyright (c) 2013 Atlassian. All rights reserved.
#
#  NSTask can't just call 'ls -l /usr/local/bin/gpg' from this application instance as it
#  doesn't have the correct permissions, so need a shell script to do this on its behalf.

#  This is purely used to see if gpg actually exists where it's meant to, and if so the
#  app delegate will automatically set the location of gpg for Sourcetree.
ls -l /usr/local/bin/gpg
