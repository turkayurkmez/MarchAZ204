#ARM template'i dağıtmak için bu scripti kullanabiliriz.
az group create --name rg-ARM --location 'westeurope'

#dağtım kodu:
az deployment group create --resource-group "rg-ARM" --name "MyDeployment_1" --template-file .\template.json --parameters appPrefix="myprefix"