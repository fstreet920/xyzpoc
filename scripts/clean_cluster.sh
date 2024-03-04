#!/bin/bash
# Uses helm to delete the xyzpoc and the ngninx installation

if [ $# -ne 1 ]; then
    echo "Usage: clean_cluster.sh context"
    echo "  context: valid kube config context"
    exit 1
fi

kubectl config use-context $1
echo -e "\n Executing helm delete on xyzpoc"
helm delete xyzpoc -n xyzpoc
echo -e "\n\n Executing helm delete on ingress-nginx"
helm delete ingress-nginx -n ingress-nginx
exit 0

