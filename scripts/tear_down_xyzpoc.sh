#!/bin/bash
# Helm deletes the nginx ingress and xyzpoc installs and calls terraform destroy.

if [ $# -ne 1 ]; then
    echo "Usage: tear_down_xyzpoc.sh context"
    echo "  context: valid kube config context"
    exit 1
fi

# check if in the scripts directory
pwd | grep -q xyzpoc/scripts$
result=$?

# exit if not executing from the scripts directory
if [ $result -ne 0 ]; then
    echo "tear_down_xyzpoc expected to be executed from the scripts directory"
    exit 1
fi

./clean_cluster.sh "$1"
cd ../terraform
echo -e "\n\n Performing terraform destroy"
terraform destroy -auto-approve

exit 0
