# App
## terminal testing:
```
pip required
Python 3.8 required
```

### pip install and dependencies
```
python -m pip install --upgrade pip
pip install coverage
pip install -r ./requirements.txt
```

## Execution from terminal
```
python3 src/xyzpoc
curl http://127.0.0.1:5000/test
```

### swagger available from local browser
http://127.0.0.1:5000/apidocs

# Commands for running linter and unittest
```
flake8 --ignore E501 src
python3 -m unittest discover src/test
coverage run --omit=/usr/lib/python3/dist-packages/* -m unittest discover src/test
coverage report -m
coverage html
```
* coverage can be viewed by loading htmlcov/index.html in the browser

# Docker commands - Requires docker installation
```
docker build . -f ./docker/Dockerfile -t streetplaya/xyzpoc:0.0.1
docker run -p 5000:5000 streetplaya/xyzpoc:0.0.1
docker push streetplaya/xyzpoc:0.0.1
```
* push requires docker account

# minkube commands - Requires minikube installation
```
minikube addon ingress
kubectl create ns xyzpoc
helm template ./chart -n xyzpoc
helm install xyzpoc ./chart -n xyzpoc
watch kubectl ingress -n xyzpoc xyzpoc-ingress
```
Once the ip address is present
```
curl http://{ingress-ip}/test
```

# Terraform
based on https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
```
terraform init
terraform apply
```
Update kube config after terraform apply finishes
```
aws eks --region us-west-2 update-kubeconfig --name xyzpoc-eks
```

# nginx
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
```

# scripts
if crlf added to shebang line -- /bin/bash^M: bad interpreter: No such file or directory.
remove with - sed
```
sed -i -e 's/\r$//' helm_deploys.sh
```
To prevent from happening add .gitattributes file with the following
```
*.sh		text eol=lf
```