STORAGE_ACCOUNT=macdkpvc
RESOURCE_GROUP=MC_mac_macdk_japaneast
LOCATION=japaneast
# STORAGE_CONTAINER=dracena

az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --location $LOCATION --https-only false
ACCOUNT_KEY=$(az storage account keys list --account-name $STORAGE_ACCOUNT | jq -r '.[0].value')

for CONTAINER in reacsim-inputs reacsim-outputs reacsim-jars reacsim-simulations
do
    az storage container create --name $CONTAINER --account-name $STORAGE_ACCOUNT --account-key $ACCOUNT_KEY
done

kubectl create secret generic reacsim-secret --from-literal azurestorageaccountname=${STORAGE_ACCOUNT} --from-literal azurestorageaccountkey=${ACCOUNT_KEY} --type=Opaque
