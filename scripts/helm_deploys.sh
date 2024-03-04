#!/bin/bash
# Uses helm to deploy nginx and xyzpoc to the provided context
# kubectl wait commands are used to wait for the nginx pod, and the xyzpoc pod to be 'ready' before continuing

if [ $# -ne 1 ]; then
    echo "Usage: helm_deploys.sh context"
    echo "  context: valid kube config context"
    exit 1
fi

kubectl config use-context $1
echo -e "\nAdding ingress-nginx to helm repo"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

echo -e "\nhelm install ingress-nginx"
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --wait 
echo -e "\nWaiting on nginx pod to be ready"
kubectl -n ingress-nginx wait --for=condition=ready pod -l app.kubernetes.io/name=ingress-nginx --timeout=300s

echo -e "\nhelm install xyzpoc"
helm upgrade --install xyzpoc ../chart -n xyzpoc --wait
echo -e "\nWaiting on xyzpod pod to be ready"
kubectl -n xyzpoc wait --for=condition=ready pod -l app=xyzpoc --timeout=120s
exit 0


