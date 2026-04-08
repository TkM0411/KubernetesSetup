variable "do_token" {
  type        = string
  description = "DigitalOcean Token"
}

variable "region" {
  type        = string
  default     = "blr1"
  description = "Region where infra is created"
}

variable "project_name" {
  type        = string
  default     = "Kubernetes"
  description = "Name of the Project"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/24"
  description = "VPC CIDR"
}

variable "droplet_size" {
  type        = string
  default     = "s-2vcpu-2gb"
  description = "Size of the VM"
}

variable "droplet_image" {
  type        = string
  default     = "ubuntu-25-10-x64"
  description = "Machine Image of the VM"
}