import requests
#AWS
#http://a6a08666364e94722b0bff7a439c4d8b-7129ec495328f8fc.elb.eu-central-1.amazonaws.com/productpage
#Fortio:
#a4acca7ba2eb14fd2a0fb05019aaad0f-808972784.eu-central-1.elb.amazonaws.com:8080/fortio
#ISTIO
#a3d6a44caf8ad467694becf25a15420b-1204233375.eu-central-1.elb.amazonaws.com/productpage
def get_qps():
    for i in range(1,31):
        url = "http://a4acca7ba2eb14fd2a0fb05019aaad0f-808972784.eu-central-1.elb.amazonaws.com:8080/fortio/data/test_743_appmesh_"+str(i)+".json"
        r= requests.get(url)
        json_data = r.json()
        print(str(int(json_data["ActualQPS"]*1000/1000)))


def get_latency(index):
    for i in range(1,31):
        url = "http://a4acca7ba2eb14fd2a0fb05019aaad0f-808972784.eu-central-1.elb.amazonaws.com:8080/fortio/data/test_istio_"+str(i)+".json"
        r= requests.get(url)
        json_data = r.json()
        print(str(int(json_data["DurationHistogram"]["Percentiles"][index]["Value"]*1000)))



def get_latency_743qps(index):
    for i in range(1,31):
        url = "http://a4acca7ba2eb14fd2a0fb05019aaad0f-808972784.eu-central-1.elb.amazonaws.com:8080/fortio/data/test_743_appmesh_"+str(i)+".json"
        r= requests.get(url)
        json_data = r.json()
        #print("QPS")
        #print(str(int(json_data["ActualQPS"]*1000/1000)))
        print(str(int(json_data["DurationHistogram"]["Percentiles"][index]["Value"]*1000)))


def qps_test_find_max():
    print("QPS")
    get_qps()
    print("p50")
    get_latency(0)
    print("p75")
    get_latency(1)
    print("p90")
    get_latency(2)
    print("p99")
    get_latency(3)
    print("p99.9")
    get_latency(4)

def get_test_2():
    print("QPS")
    get_qps()
    print("p50")
    get_latency_743qps(0)
    print("p75")
    get_latency_743qps(1)
    print("p90")
    get_latency_743qps(2)
    print("p99")
    get_latency_743qps(3)
    print("p99.9")
    get_latency_743qps(4)

get_test_2()