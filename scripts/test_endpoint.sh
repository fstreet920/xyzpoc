#!/bin/bash
# Issues curl command to test endpoint. Retries every 5 seconds for up to 5 minutes.

if [ $# -ne 1 ]; then
    echo "Usage: test_endpoint.sh context"
    echo "  context: valid kube config context"
    exit 1
fi

# switch context
kubectl config use-context $1

testing=1              # flag indicating testing endpoing
current_retry_count=0  # current number of retries
max_retries=60         # max retries
retry_delay=5          # retry delay in seconds
while [ $testing -eq 1 ] ; do
    lbarn=$(kubectl get ingress -n xyzpoc xyzpoc-ingress -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    curl http://$lbarn/test
    status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://$lbarn/test)
    if [ $status_code -ne 200 ] ; then
        echo "FAILURE non 200 code recieved: " $status_code
        current_retry_count=$((current_retry_count+1))
        # keep retrying once every 5 seconds for 5 minutes 
        if [ $current_retry_count -eq $max_retries ] ; then
            testing=0
            echo "======================================================="
            echo " DEPLOYMENT FAILURE"
            echo " Retrying attempts exhausted ... please contact support"
            echo "======================================================="
        else
            echo " Retrying in $retry_delay seconds ..."
            sleep $retry_delay
        fi
    else
        echo "================================"
        echo "DEPLOYMENT SUCCESS, 200 received"
        echo "================================"
        testing=0
    fi
done
