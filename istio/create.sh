#install istio 
.\istioctl.exe install --set profile=default           


#create application 
kubectl apply -f bookinfo.yaml
kubectl apply -f bookinfo-gateway.yaml

#perform 1st test scenario where latency is checked for max QPS and 75% of the lowest qps identified 

## later add monitoring stack when testing resource utilization
cd monitoring
kubectl apply -f .\grafana.yaml
kubectl apply -f .\prometheus.yaml