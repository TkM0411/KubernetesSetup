resource "aws_security_group" "sg_kubernetes_nodes" {
  name        = "secgrp-${local.project_code}-nodes"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    description = "Allow HTTPS Traffic within the VPC"
    cidr_blocks = [data.aws_vpc.default_vpc.cidr_block]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  ingress {
    description = "Allow HTTP Traffic within the VPC"
    cidr_blocks = [data.aws_vpc.default_vpc.cidr_block]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    description = "Allow SSH within the VPC"
    cidr_blocks = [data.aws_vpc.default_vpc.cidr_block]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    description = "Allow traffic within the same SG"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    description = "Allow all IPv4 Outbound Traffic"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = merge({
    Name = "secgrp-${local.project_code}-nodes"
  }, local.common_tags)
}

resource "aws_iam_role" "kubernetes_node_iam_role" {
  name               = "${var.project_name}IAMRole"
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_profile_trust_role.json
  tags = merge({
    Name = "IAM Role for ${var.project_name} EC2 Nodes"
  }, local.common_tags)
}

resource "aws_iam_role_policy_attachment" "managed_policies_attachments" {
  for_each   = toset(var.aws_managed_policies)
  role       = aws_iam_role.kubernetes_node_iam_role.name
  policy_arn = local.managed_policy_arns[each.key]
}

resource "aws_iam_instance_profile" "kubernetes_node_instance_profile" {
  name = "${var.project_name}InstanceProfile"
  role = aws_iam_role.kubernetes_node_iam_role.name
  tags = merge({
    Name = "EC2 Instance Profile for ${var.project_name} EC2 Nodes"
  }, local.common_tags)
}