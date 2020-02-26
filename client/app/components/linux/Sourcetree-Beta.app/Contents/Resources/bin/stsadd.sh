#!/bin/bash

#----------------------------------------------------------------------
# Create a temp script to echo the SSH password, used by SSH_ASKPASS
#----------------------------------------------------------------------

# Exit on errors
set -e

# For readability; not exported so subprocesses don't see unless we pass it
KEYFILE="$1"
PASSPHRASE="$2"
DEBUGMODE="$3"

# Skip if key already present
if [ $(ssh-add -l | grep "$KEYFILE") ]; then
    exit 0
fi

if [ ! -z "${DEBUGMODE}" ]; then
    # Tell expect to output what it's doing, this can be reported to logs by
    # caller by reading the stderr
    EXPECT_DIRECTIVES="exp_internal 1"
fi

SSH_ASKPASS_SCRIPT=$(mktemp -t ssh-askpass-script) || { echo "Failed to create temp file"; exit 1; }
cat > ${SSH_ASKPASS_SCRIPT} <<EOL
#!/usr/bin/expect -f
${EXPECT_DIRECTIVES}
spawn ssh-add -K "${KEYFILE}"
# If passphrase was already in the keychain for this file, it won't prompt
# So don't fail if it was just added successfully
expect {
    "Identity added:" {exit 0}
    "Enter passphrase for ${KEYFILE}:"
}
send "${2}\r";
expect {
    "Bad passphrase" {exit 5}
    "Identity added:"
}
wait
EOL

# Any exit from this point must clean up
# Needed in case "set -e" causes premature exit
function cleanup {
    if [ -f "${SSH_ASKPASS_SCRIPT}" ]; then
        rm -f "${SSH_ASKPASS_SCRIPT}"
    fi
}
trap cleanup EXIT

chmod u+x ${SSH_ASKPASS_SCRIPT}

# Passphrase sent to ssh-add explicitly rather than exported so it's not exposed
# to anything else we might call from this script later (more secure)
eval "${SSH_ASKPASS_SCRIPT}"

# Key should be there now, fail if not
added_keys=$(ssh-add -l)
if [ -z "$(echo $added_keys | grep $KEYFILE)" ]; then
    echo "$KEYFILE was not added successfully, only these keys present:"
    echo $added_keys
    exit 6
fi

