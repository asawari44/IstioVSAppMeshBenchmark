#!/bin/bash
#first delete gateway manually cause it causes some issues
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\09_virtual-gateway.yaml
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\08_bookinfo-appmesh.yaml
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\07_serviceaccount.yaml
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\06_appmesh-bookinfo-productpage.yaml
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\05_appmesh-bookinfo-ratings.yaml 
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\04_appmesh-bookinfo-reviews.yaml 
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\03_appmesh-bookinfo-details.yaml 
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\02_appmesh.yaml  
kubectl delete -f .\samples\bookinfo\platform\kube\aws-appmesh\01_namespace.yaml