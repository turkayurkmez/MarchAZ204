#örnek mvc projesinde; konfigürasyonu okuyacak biçimde değişiklik yaptık ve 
#aşağıdaki script ile bu değişikliği dockerize edip kaydettik:
az acr build --image "demo:v2.0" --image "demo:latest" --registry bademo --file Dockerfile .