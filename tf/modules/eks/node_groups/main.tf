data "cloudinit_config" "this" {
  # Different "parts" putting the scripts
}

resource "aws_launch_template" "this" {
  # Long list of configs
}

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.this.arn
  subnet_ids      = var.subnet_ids
}