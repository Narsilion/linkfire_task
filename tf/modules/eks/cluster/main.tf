resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids      = var.security_group_ids
    subnet_ids              = var.subnet_ids
  }
  version = var.cluster_version
}

# Here can also be a config map used by the cluster with proxy environment variables
# Also a CloudWatch log group resource for the cluster logs