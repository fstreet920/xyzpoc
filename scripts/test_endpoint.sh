#! /bin/bash

kubectl config use-context $1
lbarn=$(kubectl get ingress -n xyzpoc xyzpoc-ingress -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://$lbarn:80/test)

if [[ "$status_code" -ne 200 ]] ; then
  echo "Failure non 200 code recieved: " $status_code
else
  echo "Success, 200 received"
fi
