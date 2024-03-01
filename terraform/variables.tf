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