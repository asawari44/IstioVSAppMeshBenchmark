
qps=0
connections=32
time=3s
url="http://a6a08666364e94722b0bff7a439c4d8b-7129ec495328f8fc.elb.eu-central-1.amazonaws.com/productpage"
filename_prefix="test"

for i in {1..30}
do
   kubectl exec fortio-d54c8d974-q8mc9 -n fortio -- fortio load -qps $qps -c $connections -t $time -json ${filename_prefix}_${i}.json -a $url
   sleep 5
done