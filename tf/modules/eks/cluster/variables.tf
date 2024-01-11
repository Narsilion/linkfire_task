variable "cluster_name" {}

variable "cluster_role_name" {
  default = "eks_cluster_role"
}

variable "cluster_version" {}

variable "endpoint_private_access" {
  default = true
}

variable "endpoint_public_access" {
  default = false
}

variable "security_group_ids" {
  default = []
  type = list(string)
}

variable "subnet_ids" {
  default = []
  type = list(string)
}