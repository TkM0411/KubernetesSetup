packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "aws_access_key" {
  type    = string
  default = "${env("PKR_VAR_aws_access_key")}"
}

variable "aws_secret_key" {
  type    = string
  default = "${env("PKR_VAR_aws_secret_key")}"
}

variable "aws_region" {
  type    = string
  default = "ap-south-2"
}

variable "project_name" {
  type        = string
  default     = "Kubernetes"
  description = "Name of the Project"
}

variable "iam_instance_profile" {
  type        = string
  default     = "EC2InstanceProfileForImageBuilder"
  description = "IAM Instance Profile to Use for the Packer EC2"
}

locals {
  timestamp    = regex_replace(timestamp(), "[- TZ:]", "")
  project_code = lower(var.project_name)
  common_tags = {
    "CreatedBy"         = "TkM Packer"
    "KubernetesVersion" = "v1.34"
  }
  dynamic_tags = {
    "Name"            = "${var.project_name} AMI"
    "Created On Date" = formatdate("DD-MMM-YYYY", timeadd(timestamp(), "5h30m"))
    "Purpose"         = "Kubernetes Custom AMI"
  }
}

source "amazon-ebs" "ubuntu-base-ami" {
  ami_name      = "${local.project_code}-${local.timestamp}"
  instance_type = "t3.medium"
  region        = var.aws_region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  encrypt_boot         = true
  ssh_username         = "ubuntu"
  iam_instance_profile = var.iam_instance_profile
  tags                 = merge(local.common_tags, local.dynamic_tags)
}

build {
  name = "kubernetes-ami-build"
  sources = [
    "source.amazon-ebs.ubuntu-base-ami"
  ]

  provisioner "shell" {
    script = "AMIBuild.sh"
  }

  post-processor "manifest" {
    output = "manifest.json"
  }

  post-processor "shell-local" {
    command = "powershell -File PostProcessor.ps1"
  }
}