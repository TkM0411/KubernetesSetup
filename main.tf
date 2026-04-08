resource "digitalocean_vpc" "kubernetes_vpc" {
  name        = "${lower(var.project_name)}-vpc"
  region      = var.region
  description = "VPC for ${var.project_name}"
  ip_range    = var.vpc_cidr
}