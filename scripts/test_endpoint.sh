#!/bin/bash

kubectl config use-context $1

testing=0
loopcount=0
while [ $testing -ne 1 ] ; do
    lbarn=$(kubectl get ingress -n xyzpoc xyzpoc-ingress -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    curl http://$lbarn:80/test
    status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://$lbarn:80/test)
    if [[ "$status_code" -ne 200 ]] ; then
        echo "FAILURE non 200 code recieved: " $status_code
        loopcount=$((loopcount+1))
        # keep retrying once every 5 seconds for 5 minutes 
        if [ $loopcount -eq 60 ] ; then
            testing=1
            echo "======================================================="
            echo " Deployment FAILURE"
            echo " Retrying attempts exhausted ... please contact support"
            echo "======================================================="
        else
            echo " Retrying in 5 seconds ..."
            sleep 5
        fi
    else
        echo "================================"
        echo "DEPLOYMENT SUCCESS, 200 received"
        echo "================================"
        testing=1
    fi
done
