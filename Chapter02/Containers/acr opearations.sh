az group create -n "rg-Containers" -l "westeurope"
az acr create --resource-group "rg-Containers" -n bademo --sku Basic
az acr login -n bademo.azurecr.io

#docker image'ini etiketliyoruz:
docker build -t demo:v1
docker tag demo:v1 bademo.azurecr.io/demo:v1.0
#acr içerisine; docker image'i gönderiyoruz:
docker push bademo.azurecr.io/demo:v1.0

#image'i docker içerisinde çalıştır:
 docker run -it --rm -p 81:80 bademo.azurecr.io/demo:v1.0

 #task kullanarak; ACR üzerinde build işlemi yapılabilir.

az acr build --image demo:v2.0 --registry "bademo" --file Dockerfile .
az acr repository show-tags --name "bademo" --repository demo

# ACI ile çalıştırma:

#1. ACR'a yetki verin:
az acr update -n "bademo" --admin-enabled true
#2. ACR'in şifresini al:
$pass = (az acr credential show -n "bademo" --query "passwords[0].value")
#3. Artık yeni bir instance ACI oluşturabiliriz.

az container create -g "rg-Containers" -n "bademo" --image "bademo.azurecr.io/demo:v2.0" --cpu 1 --memory 1 --registry-login-server "bademo.azurecr.io" --registry-username "bademo" --registry-password $pass --ports 80 --dns-name-label "testba"
