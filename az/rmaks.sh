#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

ROOT="$(
    cd "$(dirname "$0")/../"
    pwd
)"

source ${ROOT}/az/env

az aks delete -n $CLUSTER -g $RESOURCE_GROUP -y
