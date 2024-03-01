variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

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

variable "aws_auth_accounts_list" {
  type        = list(string)
  description = "list of account ids"
  default     = [
    "469401808563",
  ]
}

variable "vpc_name" {
  type        = string
  description = "name for the deployed vpc"
  default     = "xyzpoc-vpc"
}

variable "eks_cluster_name" {
  type        = string
  description = "name for the deployed vpc"
  default     = "xyzpoc-eks"
}

variable "xyzpoc_namespace" {
  type        = string
  description = "namespace name used later in deployment of xyzpoc resources"
  default     = "xyzpoc"
}

variable "nginx_namespace" {
  type        = string
  description = "namespace name for nginx"
  default     = "ingress-nginx"
}
