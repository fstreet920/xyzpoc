# xyzpoc
POC for deploying sample application with a REST endpoint to the cloud in a Kubernetes environment. Deployed by executing deploy_xyzpoc.sh from within the scripts directory.

## Prerequisites
* aws cli installed in linux or wsl
  [aws cli installation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  [aws cli configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
* terraform installed in linux or wsl
  [terraform installation documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* aws user with correct privileges. Tested with an AWS user with the AdministratorAccess Policy
 ```
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
 }
 ```
* helm installed in linux or wsl
  [helm installation](https://helm.sh/docs/intro/install/)
* kubectl installed in linux or wsl
  [kubectl installation](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

# Deployment
1. Open a bash terminal and change directories to the scripts directory.
2. In the terminal type `.\deploy_xyzpoc.sh` and press enter. This script will do the following:
* `terraform init`  Code found in the script `create_eks_cluster.sh`
* `terraform apply` which creates the xyzpoc-eks kubernetes cluster in AWS. Code found in the script `create_eks_cluster.sh`
* Updates the kube config so the current context is pointing to the xyzpod-eks kubernetes cluster. Code found in the script `create_eks_cluster.sh`
* Executes a helm deployment of nginx into the ingress-nginx namespace (created by terraform). Waits on the ingress-nginx-controller pod to be 'Ready'. Code found in the script `helm_deploys.sh`
* Executes a helm deployment of xyzpoc into the xyzpoc namespace (created by terraform). Waits on the xzypoc pod to be 'Ready'. Code found in the script `helm_deploys.sh`
* The status of xyzpoc pod is checked to make sure it is 'Running' before testing the endpoint. Code in `deploy_xyzpoc.sh`
* Endpoint is tested by obtaining the Loadbalancer Url from the xyzpoc-ingress and curling the /test endpoint. A result of 200 determines that the deployment is successful.  The test logic will retry the endpoint after 5 seconds if there is a non 200 response received, there are 60 retry attempts before declaring the deployment failed.

# Cleanup
1. Make sure you have the xyzpoc kube context value.  `kubectl config current-context` should be able to provide that if you haven't switched kube config contexts.
2. Open a bash terminal and change directories to the scripts directory.
3. In the terminal type `.\tear_down_xyzpoc.sh <xyzpoc kube context>` and press enter. This script will do the following:
* change kube config context to provided xyzpoc context
* helm delete xyzpoc installation, and then the ingress-nginx installation.
* change to the terraform directory and execute `terraform destroy`
* change back to the scripts directory

# Config Values
The following values can be changed in the terraform/variables.tf
* region - the AWS region the EKS cluster is created in.  Currently set to us-west-2.
* aws_auth_users_list - users allowed to view EKS node details in aws console.

# Making code updates and re-deploying to existing cluster
## Development
follow regular git procedures
```
git clone
git checkout -b development-branch
```
When you push the development-branch (example name, use your branch name) a docker image will be published to the streetplaya/xyzpoc public docker repo with the tag, branchname-latest, added to the image. To test this in your cluster:
* edit chart/values.yaml, changing the line - image: docker.io/streetplaya/xyzpoc:v0.0.1 replacing v0.0.1 with the branchname-latest tag. 
* note - merges to main will publish an image tagged :main-latest.

Then do a helm update to your cluster.  Open a bash terminal and from this repo's root issue the following:
```
helm upgrade --install xyzpoc ../chart -n xyzpoc --wait
```

### CI
When a dev branch is pushed or a branch is merged into main, the GitHub Actions for Continuous integration witll be executed. These are defined in .github/workflows/ci-actions.yml. These actions will:
* Checkout the code
* Run the unittest
* Run the linter (flake8)
* Generate code coverage report from the unittest execution
* Save the code coverage report as an artifact.
* publish the docker image to the public docker repo streetplaya/xyzpoc

Results and execution can be viewed in github on the Actions tab.
![Example Github Action Result](docs/GithubActions.PNG)
 

## Release
To release a new version once you are satisfied with the changes in the image tagged :main-latest, add a git tag to the main branch.
```
git checkout main
git pull origin main
git tag v0.0.2
git push origin v0.0.2
```
Don't forget to update image in the chart/values.yaml like above in the development notes to the new image tag. Example -
```
image: docker.io/streetplaya/xyzpoc:v0.0.2
```


# Changes to the POC for 'Production'
* Define least privileges required for AWS user to allow setting up EKS cluster with terraform and for interacting with cluster through kubectl and EKS console.
* Use Route53 and ACM to use https instead of http. (cert manager, external dns)
* Fix tagging to only publish Docker image with tag if on main branch
* Right size the cluster
* Add CD like FluxCD or ArgoCD
* Add node autoscaling
* Add pod autoscaling (HPA)
* Add container scanning for vulnerabilities
* Add powershell scripts for Windows support

# [Presentation](docs/presentation.md)

[testing notes](docs/testing_notes.md)