#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

SIMULATION_ID=$1
USECASE=$2

cat > template/${USECASE}/reacsim.env << EOF
SIMULATION_ID=${SIMULATION_ID}
ENV_JSON=/opt/inputs/${SIMULATION_ID}/env.json
REACSIM_CONFIG_FILE=/opt/inputs/${SIMULATION_ID}/config.yml
DMM_MODEL_INFO_FILE=${SIMULATION_ID}/model.zip
DUMPER_OUTPUT_DIR=/opt/outputs/${SIMULATION_ID}
ROOT_PATH=/opt/inputs/${SIMULATION_ID}/2
EOF

### opentripplanner用のconfigmap
cat > template/opentripplanner/opentripplanner.env << EOF
JAVA_OPTS=-Dlogback.configurationFile=/opt/inputs/${SIMULATION_ID}/1/logback.xml
JAVA_TOOL_OPTIONS=-XX:InitialRAMPercentage=70 -XX:MaxRAMPercentage=70
CONFIG_DIR=/opt/inputs/${SIMULATION_ID}/1
EOF

./mkdatepvc.sh $SIMULATION_ID ${USECASE}
kubectl apply -f kafka-only-ephemeral-single-node.yaml
kubectl apply -k template/${USECASE}/
