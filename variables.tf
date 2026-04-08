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