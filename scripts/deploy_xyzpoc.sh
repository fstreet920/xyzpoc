#!/bin/bash
# Deploys xyzpoc to AWS.  Creates and eks cluster, deploys nginx and xyzpoc, and tests the endpoint for a valid return.

echo "Deploying xyzpoc"
echo -e "Creating Cluster\n\n\n"
./create_eks_cluster.sh
curr_context=$(kubectl config current-context)

echo -e "\nPerforming Helm installs/updates\n\n"
./helm_deploys.sh "$curr_context"

# Get the xyzpoc pod status
pod_status=$(kubectl get pod -l app=xyzpoc -n xyzpoc -o jsonpath='{.items[0].status.phase}')

# Check xyzpoc pod is running
if [ "$pod_status" == "Running" ]; then
  echo -e "\n\nxyzpoc Pod running\n\n"
  echo Testing Endpoint
  ./test_endpoint.sh "$curr_context"
else
  echo "\n\nDEPLOYMENT FAILURE: xyzpoc Pod not running, Current status: $pod_status"
fi


