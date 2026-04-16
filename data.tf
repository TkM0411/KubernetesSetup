data "aws_caller_identity" "current" {}

data "aws_region" "current_region" {}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_iam_policy_document" "ec2_instance_profile_trust_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_ssm_parameter" "kubernetes_ec2_ami" {
  name = "/${var.ami_project_name}/packer/ami"
}