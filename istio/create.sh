.\istioctl.exe install --set profile=default           

kubectl apply -f .\samples\bookinfo\platform\kube\istio\bookinfo.yaml
kubectl apply -f .\samples\bookinfo\platform\kube\istio\bookinfo-gateway.yaml