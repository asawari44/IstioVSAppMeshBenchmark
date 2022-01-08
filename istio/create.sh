#install istio 
.\istioctl.exe install --set profile=default           

kubectl apply -f bookinfo.yaml
kubectl apply -f bookinfo-gateway.yaml