variable "cluster_name" {}

variable "coredns_addon_name" {
  default = "coredns"
}

variable "coredns_version" {}

variable "coredens_replica_count" {
  default = 2
}