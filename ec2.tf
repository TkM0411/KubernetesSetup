resource "aws_instance" "kubernetes_master_node" {
    ami = data.aws_ssm_parameter.kubernetes_ec2_ami.value
    vpc_id = data.aws_vpc.default_vpc.id
    instance_type = var.ec2_instance_type
    availability_zone = var.default_availability_zone
    
}