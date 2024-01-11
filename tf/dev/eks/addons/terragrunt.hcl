include {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../../modules/esk/addons"
}

inputs {
  cluster_name    = "my_super_cluster"
  coredns_version = "v.10.1-eksbuild.6"
}