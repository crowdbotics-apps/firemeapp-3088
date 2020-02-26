#!/bin/sh

# git merge-index needs a single program name, so we encapsulate 'git merge-one-file' in a script
git merge-one-file "$@"
