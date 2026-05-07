variable "access_key" {
  type        = string
  description = "AWS Access Key"
}

variable "secret_key" {
  type        = string
  description = "AWS Secret Key"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "ap-south-2"
}

variable "project_name" {
  type        = string
  description = "Name of the Project"
  default     = "Kubernetes"
}

variable "owner" {
  type        = string
  description = "Name of the Resource Owner"
  default     = "TkM"
}

variable "aws_managed_policies" {
  type        = list(string)
  description = "List of AWS Managed IAM Policies"
  default = [
    "AmazonSSMManagedEC2InstanceDefaultPolicy",
    "AmazonSSMManagedInstanceCore",
    "AmazonSSMFullAccess"
  ]
}

variable "ami_project_name" {
  type        = string
  description = "Name of the Project for fetching the correct AMI"
  default     = "k8nsetup"
}

variable "ec2_instance_type" {
  type        = string
  description = "Type of EC2 Instances"
  default     = "medium"
}

variable "default_availability_zone" {
  type        = string
  description = "Default Availability Zone"
  default     = "ap-south-2a"
}

variable "is_minikube_setup" {
  type        = bool
  description = "Determines whether we need a MiniKube Setup"
  default     = true
}

variable "architecture" {
  type        = string
  description = "CPU Architecture"

  validation {
    condition     = contains(["amd64", "arm64"], var.architecture)
    error_message = "Architecture must be either 'amd64' or 'arm64'."
  }
}