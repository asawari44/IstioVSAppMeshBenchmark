kubectl apply -f 01_namespace.yaml
kubectl apply -f 02_appmesh.yaml  
kubectl apply -f 03_appmesh-bookinfo-details.yaml 
kubectl apply -f 04_appmesh-bookinfo-reviews.yaml 
kubectl apply -f 05_appmesh-bookinfo-ratings.yaml 
kubectl apply -f 06_appmesh-bookinfo-productpage.yaml
kubectl apply -f 07_serviceaccount.yaml
kubectl apply -f 08_bookinfo-appmesh.yaml
kubectl apply -f 09_virtual-gateway.yaml


# the last command creates an ingress gateway service exposing the service mesh with an ingress gateway that has a loadbalancer attached to it.
# if any errors, go to AWS App Mesh and create the gateway manually by refering to  09_virtual-gateway.yaml