resource "aws_security_group" "sg_kubernetes_nodes" {
  name        = "secgrp-${local.project_code}-nodes"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    description = "Allow traffic within the same SG"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  tags = merge({
    Name = "sg-${local.project_code}-nodes"
  }, local.common_tags)
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.sg_kubernetes_nodes.id
  description       = "Allow HTTPS Traffic within the VPC"
  cidr_ipv4         = data.aws_vpc.default_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.sg_kubernetes_nodes.id
  description       = "Allow HTTP Traffic within the VPC"
  cidr_ipv4         = data.aws_vpc.default_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.sg_kubernetes_nodes.id
  description       = "Allow SSH within the VPC"
  cidr_ipv4         = data.aws_vpc.default_vpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}