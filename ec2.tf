resource "aws_instance" "kubernetes_master_node" {
  ami                         = data.aws_ssm_parameter.kubernetes_ec2_ami.value
  instance_type               = var.ec2_instance_type
  availability_zone           = var.default_availability_zone
  force_destroy               = true
  hibernation                 = true
  iam_instance_profile        = aws_iam_instance_profile.kubernetes_node_instance_profile.id
  vpc_security_group_ids      = [aws_security_group.sg_kubernetes_nodes.id]
  user_data                   = file("${path.module}/UserDataScripts/master-node.sh")
  user_data_replace_on_change = true
  tags = merge({
    Name = "${var.project_name} Master Node"
  }, local.common_tags)
}

resource "aws_instance" "kubernetes_worker_node" {
  ami                         = data.aws_ssm_parameter.kubernetes_ec2_ami.value
  instance_type               = var.ec2_instance_type
  availability_zone           = var.default_availability_zone
  force_destroy               = true
  hibernation                 = true
  iam_instance_profile        = aws_iam_instance_profile.kubernetes_node_instance_profile.id
  vpc_security_group_ids      = [aws_security_group.sg_kubernetes_nodes.id]
  user_data                   = file("${path.module}/UserDataScripts/worker-node.sh")
  user_data_replace_on_change = true
  tags = merge({
    Name = "${var.project_name} Worker Node"
  }, local.common_tags)
}