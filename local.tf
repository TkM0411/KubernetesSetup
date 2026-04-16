locals {
  project_code = lower(var.project_name)
  common_tags = {
    Owner       = "${var.owner}"
    CreatedDate = "${formatdate("DD-MM-YYYY", timestamp())}"
    Project     = "${var.project_name}"
  }
  managed_policy_arns = zipmap(var.aws_managed_policies, [
    for policy in var.aws_managed_policies : "arn:aws:iam::aws:policy/${policy}"
  ])
}