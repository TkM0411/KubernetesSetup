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