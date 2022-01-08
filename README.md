# IstioVSAppMeshBenchmark
This repository contains code for application deployment and benchmarking for both Istio and AppMesh 

## Prerequisites 
  - AWS Account with access to EKS , AWS App Mesh and AWS X-ray services
  - Istioctl installed on the local machine. 
  - Lens installed on localmachine 
  
## Process to reproduce the benchmarking setup - 

1. Launch an EKS cluster in AWS with 3 nodes and label the nodes as system, istio and app-mesh respectively. (More nodes can be launched to increase cluster capacity but to ensure that both istio-meshed and appMesh-meshed application have the same resource availability, the number of nodes allocated for istio and AppMesh deployment should be the same.)
2. Connect to Lens and check the assigned labels.
3. Install AWS App Mesh on the cluster. 
4. Deploy the application using scripts under aws-appmesh.
5. Launch fortio using manifest files in the fortio folder. It should be exposed using the loadbalancer at <FORTIO_LB_DNS>:8080/fortio
6. Test if aws app meshed application is available by reaching the url via browser or this can also be tested using fortio command.
'''
kubectl exec <pod> -n fortio -- fortio load -qps 0 -c 32 -t 3s http://<AWS_INGRESS_DNS>/productpage 
'''
7. Execute find_max_qps.sh script in fortio folder to retrieve 30 data sets in json format. After the execution, this data is available at <FORTIO_LB_DNS>:8080/fortio/data
8. From this data we scraped QPS values and different percentile latencies such as p50, p75, p90, p99 and p99.9 using fortio/scrape_data.py. This script can be tweaked to gather more data from available json dataset for 30 samples. 
9. Excel is then used to plot graphs that show QPS trend and line charts for latencies
10. After the test, AWS app mesh app and mesh control plane are removed and Istio is installed . All the above steps from step 4 are repeated to gather data for istio-meshed app. 
  
