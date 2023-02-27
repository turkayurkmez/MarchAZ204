# Variables
$RG_NAME="rg-AZ-204"
$LOCATION="westeurope"
$VM_SIZE="Standard_B1s"
$WIN_VM_NAME="VM-WIN-WEU-C2-1"
$UBU_VM_NAME="VM-UBU-WEU-C2-1"
$WIN_URN="MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest"
$UBU_URN="Canonical:UbuntuServer:19.04:latest"
$ADMIN_USER="adminperson"
$USER_DATA="Hello, World!"
$TAG="Chapter"=2


az group create --name $RG_NAME --location $LOCATION --tags $TAG


az vm create --name $WIN_VM_NAME --resource-group $RG_NAME --location $LOCATION --size $VM_SIZE --image $WIN_URN --admin-username $ADMIN_USER --user-data "$USER_DATA"


az vm create --name $UBU_VM_NAME --resource-group $RG_NAME --location $LOCATION --size $VM_SIZE --image $UBU_URN --admin-username $ADMIN_USER --user-data "$USER_DATA" --authentication-type password
