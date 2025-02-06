#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

USECASE=$1

kubectl delete -k template/${USECASE}/
kubectl delete -f kafka-only-ephemeral-single-node.yaml
kubectl delete -f reacsim-data/

