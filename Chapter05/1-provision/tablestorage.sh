############################################################
#These commands should be executed from Azure Cloud Shell bash 
############################################################

#create the resource group
az group create -l westeurope -n rg-AzureTables

#to avoid name collisions generate the unique name for your account
account=azuretables$RANDOM

#create Azure Storage Account 
az storage account create --name $account --resource-group rg-AzureTables  

#retrive key
key=$(az storage account keys list --account-name $account --query [0].value -o tsv)

#create Azure Table storage account by using key
az storage table create --name customers --account-name $account  --account-key $key

#insert entity to the table
az storage entity insert  --account-name $account --account-key $key --entity PartitionKey=ReSellers RowKey=Contoso IsActive=true IsActive@odata.type=Edm.Boolean --if-exists fail --table-name customers
az storage entity insert  --account-name $account --account-key $key --entity PartitionKey=ReSellers RowKey=Woodgrow IsActive=true IsActive@odata.type=Edm.Boolean --if-exists fail --table-name customers
az storage entity insert  --account-name $account --account-key $key --entity PartitionKey=Sellers RowKey=TailSpinToys IsActive=false IsActive@odata.type=Edm.Boolean --if-exists fail --table-name customers

#generate SAS for access to the REST endpoint
sas=$(az storage table generate-sas --name customers  --account-name $account --account-key $key --permissions r --expiry 2200-01-01)

#replase quotes 
sas=${sas//\"/}
echo $sas

#use generated SAS and request entities in JSON format 
echo https://$account.table.core.windows.net/customers\(\)?$sas\&\$format=json

#use generated SAS and request only active customers (IsActive = true) 
echo https://$account.table.core.windows.net/customers\(\)?$sas\&\$format=json\&\$filter=IsActive%20eq%20true

#use generated SAS and receive customer by keys
echo https://$account.table.core.windows.net/customers\(\)?$sas\&\$format=json\&\$filter=IsActive%20eq%20true