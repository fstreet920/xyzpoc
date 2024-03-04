# region to deploy eks cluster
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

# users for aws auth - allows viewing node info in eks dashboard
variable "aws_auth_users_list" {
  type        = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  description = "list of user objects"
  default     = [
    {
      userarn  = "arn:aws:iam::469401808563:root"
      username = "root"
      groups   = ["system:masters"]
    },
  ]
}

# vpc name
variable "vpc_name" {
  type        = string
  description = "name for the deployed vpc"
  default     = "xyzpoc-vpc"
}

# cluster name, also used in scripts for updating kube config
variable "eks_cluster_name" {
  type        = string
  description = "name for the deployed vpc"
  default     = "xyzpoc-eks"
}

# namespace for xyzpoc, used in scripts and helm deployment
variable "xyzpoc_namespace" {
  type        = string
  description = "namespace name used later in deployment of xyzpoc resources"
  default     = "xyzpoc"
}

# namespace for nginx, used in scripts and helm deployment
variable "nginx_namespace" {
  type        = string
  description = "namespace name for nginx"
  default     = "ingress-nginx"
}
