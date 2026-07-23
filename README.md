# IstioVSAppMeshBenchmark
This repository contains code for application deployment and benchmarking for both Istio and AWS App Mesh.

## Repository Structure

```
IstioVSAppMeshBenchmark/
├── aws-appmesh/          # Kubernetes manifests and scripts to deploy the App Mesh-meshed bookinfo app
├── istio/                # Kubernetes manifests and scripts to deploy the Istio-meshed bookinfo app
│   └── monitoring/       # Grafana, Prometheus, Kiali, and Jaeger manifests for resource utilization tests
├── fortio/               # Load testing manifests, scripts, and data scraping utilities
├── locust/               # Additional virtual node configuration for Locust-based load testing
└── resource_util_data/   # Collected CPU and memory data for both control plane and data plane
    ├── appmesh/
    └── istio/
```

## Prerequisites

- AWS Account with access to EKS, AWS App Mesh, and AWS X-Ray services
- `istioctl` installed on the local machine
- Lens installed on the local machine

## Process to Reproduce the Benchmarking Setup

### Phase 1 — AWS App Mesh

1. Launch an EKS cluster in AWS with 3 nodes and label the nodes as `system`, `istio`, and `app-mesh` respectively. (More nodes can be added to increase cluster capacity, but to ensure that both the Istio-meshed and App Mesh-meshed applications have the same resource availability, the number of nodes allocated to each mesh must be equal.)
2. Connect to Lens and verify the assigned node labels.
3. Install AWS App Mesh on the cluster.
4. Deploy the application by running `create_all.sh` from the `aws-appmesh/` directory:
   ```bash
   cd aws-appmesh
   ./create_all.sh
   ```
   This applies all manifests in order, ending with a virtual gateway that exposes the service mesh via a LoadBalancer.
5. Launch Fortio using the manifest files in the `fortio/` directory. The UI will be exposed at `<FORTIO_LB_DNS>:8080/fortio`.
   ```bash
   kubectl apply -f fortio/deployment.yml
   kubectl apply -f fortio/service.yml
   ```
6. Verify the App Mesh-meshed application is reachable via browser at the AWS ingress DNS, or with Fortio:
   ```bash
   kubectl exec <pod> -n fortio -- fortio load -qps 0 -c 32 -t 3s http://<AWS_INGRESS_DNS>/productpage
   ```
7. Run `find_max_qps.sh` in the `fortio/` directory to collect 30 data sets in JSON format. After execution, results are available at `<FORTIO_LB_DNS>:8080/fortio/data`.
   ```bash
   cd fortio
   ./find_max_qps.sh
   ```
8. Use `fortio/scrape_data.py` to extract QPS values and latency percentiles (p50, p75, p90, p99, p99.9) from the 30 JSON samples. The script can be modified to extract additional fields from the dataset.
9. Use Excel (or equivalent) to plot QPS trend charts and latency line charts from the scraped data.

### Phase 2 — Istio

10. Tear down the App Mesh application and control plane using `aws-appmesh/delete_all.sh`, then install Istio and deploy the application using `istio/create.sh`:
    ```bash
    cd aws-appmesh
    ./delete_all.sh

    cd ../istio
    # Edit create.sh to ensure istioctl path is correct for your OS, then run:
    ./create.sh
    ```
11. For resource utilization tests, deploy the monitoring stack from `istio/monitoring/`:
    ```bash
    kubectl apply -f istio/monitoring/prometheus.yaml
    kubectl apply -f istio/monitoring/grafana.yaml
    kubectl apply -f istio/monitoring/kiali.yaml
    kubectl apply -f istio/monitoring/jaeger.yaml
    ```
12. Repeat steps 5–9 to collect and analyze the equivalent Fortio load test data for the Istio-meshed application.
