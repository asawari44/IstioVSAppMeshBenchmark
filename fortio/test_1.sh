for i in {3..30}
do
   kubectl exec fortio-d54c8d974-q8mc9 -n fortio -- fortio load -qps 0 -c 250 -t 30s -json test_$i.json -a http://a6a08666364e94722b0bff7a439c4d8b-7129ec495328f8fc.elb.eu-central-1.amazonaws.com/productpage
   sleep 5
done