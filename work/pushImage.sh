#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

ACR=macfltechdev
TAG=2024-3q

az acr login -n $ACR

function pushImage () {
    local image=$1
    local tag=$2
    

    pushTag=${ACR}.azurecr.io/${image}:${tag}
    docker tag ${image}:${tag} ${pushTag}
    docker push ${pushTag}
}


# pushImage start ${TAG}
# pushImage progress ${TAG}
# pushImage sdt-dmm-service ${TAG}
# pushImage dmm ${TAG}
# pushImage dumperjs ${TAG}
# pushImage javaruntime ${TAG}
# pushImage sumo-v2.1 ${TAG}
pushImage end ${TAG}