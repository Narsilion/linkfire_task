include {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../../modules/eks/cluster"
}

inputs {
  cluster_name       = "my_super_cluster"
  cluster_version    = "1.28"
  security_group_ids = ["sg-s2djfdsjrhfsdf"]
  subnet_ids         = ["subnet-0dgfd5gfd42gdfd"]
}