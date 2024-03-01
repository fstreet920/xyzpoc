#! /bin/bash

kubectl config use-context $1
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx 

helm install xyzpoc ../chart -n xyzpoc
