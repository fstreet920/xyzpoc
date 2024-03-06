![KeepCalm](KeepCalm.PNG)

# Intro

# Objectives
Deploy app with REST endpoint to the cloud in a kubernetes cluster. Ensure code quality of application is maintained.
* Create GitHub repo
* Create application with unit tests
* Containerize application and test
* Add GitHub actions for testing code and code coverage
* Test pushing and pulling to Docker Hub
* Add helm chart for application - secrets, deployment, and service
* Validate with helm template
* Validate in minikube with helm installs
* Test with nginx ingress in minikube
* Create terraform to provision eks cluster and test helm deployments
* Write scripts for single command deployment
* Add environment tests to scripts
* Update README.md
* Create presentation

# Technologies Used
* GitHub
* Python
* Flask
* Flasgger
* unittest
* code coverage
* Docker
* Github Actions
* helm
* kubernetes
* minikube
* nginx
* Terraform
* bash scripting

# Lessons Learned
* Setting flask port through environment variable - LISTENING_PORT
* Minikube has its own nginx addon - useful but didn't catch ingress definition errors
* bash scripting - make sure to update .gitattributes so crlf isn't added!
* bash scripting - some refreshing of knowledge was required :-)
* tagging image with git tag, making sure only executes on main branch
* Docker Access Tokens
* Spent some time looking at awk for kubectl environment, then started using jsonpath.
* Terraform plan, saving the plan file and then using that with the apply command.

# Changes to the POC for 'Production'
* Define least privileges required for AWS user to allow setting up EKS cluster with terraform and for interacting with cluster through kubectl and EKS console.
* Use Route53 and ACM to use https instead of http. (cert manager, external dns)
* Add unit tests for probe endpoints
* Add terraform plan with approval and then have terraform apply execute that plan
* Right size the cluster
* Add CD like FluxCD or ArgoCD
* Add node autoscaling
* Add pod autoscaling (HPA)
* Add container scanning for vulnerabilities
* Add powershell scripts for Windows support
* Move terraform to github actions
* Package helm chart and save in registry

