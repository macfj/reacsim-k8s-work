#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

SIMULATION_ID=sim-e230fda3-9850-4173-97e4-05d2d8e00d1b
USECASE=park-and-ride

./start.sh $SIMULATION_ID $USECASE
