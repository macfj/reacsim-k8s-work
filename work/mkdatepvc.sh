#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

SIMULATION_ID=$1
USECASE=$2

kubectl exec -i deployments/reacsim-data -- mkdir -p /opt/simulations/${SIMULATION_ID}
( cd sim-params/${USECASE} && tar cf - . ) | kubectl exec -i deployments/reacsim-data -- tar xvf - -C /opt/simulations
kubectl exec -i deployments/reacsim-data -- cp /opt/simulations/env.json /opt/simulations/${SIMULATION_ID}
kubectl exec -i deployments/reacsim-data -- chown -R 1000:1000 /opt/simulations

kubectl exec -i deployments/reacsim-data -- rm -rf /opt/inputs/${SIMULATION_ID}
kubectl exec -i deployments/reacsim-data -- mkdir -p /opt/inputs/${SIMULATION_ID}
kubectl exec -i deployments/reacsim-data -- mkdir -p /opt/inputs/${SIMULATION_ID}/1
kubectl exec -i deployments/reacsim-data -- mkdir -p /opt/inputs/${SIMULATION_ID}/2
kubectl exec -i deployments/reacsim-data -- mkdir -p /opt/inputs/${SIMULATION_ID}/3
kubectl exec -i deployments/reacsim-data -- rm -rf /opt/outputs/${SIMULATION_ID}
kubectl exec -i deployments/reacsim-data -- mkdir -p /opt/outputs/${SIMULATION_ID}
kubectl exec -i deployments/reacsim-data -- chown -R 1000:1000 /opt/inputs/${SIMULATION_ID} /opt/outputs/${SIMULATION_ID}
