#! /bin/bash

kubectl config use-context $1
helm delete xyzpoc -n xyzpoc
helm delete ingress-nginx -n ingress-nginx

