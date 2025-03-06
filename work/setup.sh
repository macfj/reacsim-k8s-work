#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

kubectl apply -f setup/

# create storage account and set secret
./secret.sh
# create data storage pod
./mkdatapod.sh
