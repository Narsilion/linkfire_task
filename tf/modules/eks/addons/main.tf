resource "aws_eks_addon" "coredns" {
  cluster_name      = var.cluster_name
  addon_name        = var.coredns_addon_name
  addon_version     = var.coredns_version
  resolve_conflicts = "OVERWRITE"

  configuration_values = jsonencode({
    replicaCount = var.coredens_replica_count
  })
}

# Many other addons go here such as VPC CNI, kube-proxy
# Also, iam_role and iam_role_policy_attachment for these addons with required permissions