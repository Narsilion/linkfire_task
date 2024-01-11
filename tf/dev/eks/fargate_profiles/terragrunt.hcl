include {
    path = find_in_parent_folders()
}

terraform {
    source = "${path_relative_from_include()}/../../modules/eks/cluster"
}

inputs {
  cluster_name           = "my_super_cluster"
  fargate_profile_name   = "superapp"
  pod_execution_role_arn = "arn:aws:iam:11111111:role/fargate_profile_role"
}