#!/bin/bash

# check if in the scripts directory
pwd | grep -q xyzpoc/scripts$
result=$?

if [ $result -ne 0 ]; then
    echo "create_eks_cluster expected to be executed from the scripts directory"
    exit 1
fi

echo Launching terraform
cd ../terraform
terraform init
terraform apply -auto-approve

echo -e "\nUpdating kube config"
aws eks --region us-west-2 update-kubeconfig --name xyzpoc-eks

cd ../scripts
exit 0