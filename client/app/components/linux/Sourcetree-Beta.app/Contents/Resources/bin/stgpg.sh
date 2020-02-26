#!/bin/sh
# set --batch and --no-tty to stop it needing the terminal
# otherwise it will fail through ST as it's GUI-only.
gpg2 --batch --no-tty "$@"
