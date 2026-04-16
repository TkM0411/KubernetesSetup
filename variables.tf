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