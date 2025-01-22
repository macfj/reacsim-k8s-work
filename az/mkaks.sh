#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR: $BASH_SOURCE:$LINENO $BASH_COMMAND" >&2' ERR

ROOT="$(
    cd "$(dirname "$0")/../"
    pwd
)"

source ${ROOT}/az/env

NODENUM=${AKS_NODE_COUNT:-6}

az aks create --resource-group $RESOURCE_GROUP --location $LOCATION \
    --name $CLUSTER \
    --node-vm-size Standard_B4ms --node-count $NODENUM \
    --ssh-key-value ~/.ssh/id_rsa.pub \
    --attach-acr $ACR \
    --enable-managed-identity
    # --zones 1 2 3
    # --enable-addons monitoring,azure-keyvault-secrets-provider \
az aks get-credentials --name $CLUSTER -g $RESOURCE_GROUP --overwrite-existing

# kubectl create namespace $CLUSTER
