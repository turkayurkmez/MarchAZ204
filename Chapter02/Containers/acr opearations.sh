az group create -n "rg-Containers" -l "westeurope"
az acr create --resource-group "rg-Containers" -n bademo --sku Basic
az acr login -n bademo.azurecr.io