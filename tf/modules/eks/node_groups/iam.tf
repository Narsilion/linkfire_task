resource "aws_iam_role" "this" {
  assume_role_policy = <<POLICY
{
.....
}
POLICY
}

# Then we have different policies and their attachment
 resource "aws_iam_instance_profile" "this" {
   name = "${var.cluster_name}-eks-node-instane-profile"
   role = aws_iam_role.this.arn
 }