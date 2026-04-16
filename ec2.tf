resource "aws_ebs_volume" "master_ebs_volume" {
  availability_zone = "ap-south-2a"
  size              = 32
  encrypted         = true
  type              = "gp3"
  tags = merge({
    Name = "${var.project_name} Master Node EBS Volume"
  }, local.common_tags)
}

resource "aws_ebs_volume" "worker_ebs_volume" {
  availability_zone = "ap-south-2a"
  size              = 16
  encrypted         = true
  type              = "gp3"
  tags = merge({
    Name = "${var.project_name} Worker Node EBS Volume"
  }, local.common_tags)
}