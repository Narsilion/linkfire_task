variable "cluster_name" {}

variable "node_group_name" {}

variable "subnet_ids" {
  default = []
  type = list(string)
}