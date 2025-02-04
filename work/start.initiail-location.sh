#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

SIMULATION_ID=sim-e230fda3-9850-4173-97e4-05d2d8e00d1b
USECASE=initial-location

cat > template/${USECASE}/reacsim.env << EOF
SIMULATION_ID=${SIMULATION_ID}
ENV_JSON=/opt/inputs/${SIMULATION_ID}/env.json
REACSIM_CONFIG_FILE=/opt/inputs/${SIMULATION_ID}/config.yml
DMM_MODEL_INFO_FILE=${SIMULATION_ID}/model.zip
DUMPER_OUTPUT_DIR=/opt/outputs/${SIMULATION_ID}
EOF

./mkdatepvc.sh $SIMULATION_ID ${USECASE}
kubectl apply -f kafka-only-ephemeral-single-node.yaml
kubectl apply -k template/${USECASE}/
