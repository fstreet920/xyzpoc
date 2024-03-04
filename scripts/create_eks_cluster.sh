#!/bin/bash
# Creates the eks cluster through terraform and updates the kube config.

# check if in the scripts directory
pwd | grep -q xyzpoc/scripts$
result=$?

# exit if not executing from the scripts directory
if [ $result -ne 0 ]; then
    echo "create_eks_cluster expected to be executed from the scripts directory"
    exit 1
fi

echo Launching terraform
cd ../terraform
terraform init
terraform apply -auto-approve

# update the kube config
echo -e "\nUpdating kube config"
aws eks --region us-west-2 update-kubeconfig --name xyzpoc-eks

cd ../scripts
exit 0