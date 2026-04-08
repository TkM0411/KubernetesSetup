resource "digitalocean_vpc" "kubernetes_vpc" {
  name        = "${local.project_code}-vpc"
  region      = var.region
  description = "VPC for ${var.project_name}"
  ip_range    = var.vpc_cidr
}

resource "tls_private_key" "droplet_tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "droplet_ssh_key" {
  name       = "${local.project_code}-droplet-key"
  public_key = tls_private_key.droplet_tls_private_key.public_key_openssh
}

resource "digitalocean_spaces_bucket" "setup_data_exchange_bucket" {
  name          = "${local.project_code}-setup-data-exchange"
  region        = var.region
  force_destroy = true
}

resource "digitalocean_droplet" "kubernetes_master" {
  image             = var.droplet_image
  name              = "${local.project_code}-master"
  region            = var.region
  size              = var.droplet_size
  vpc_uuid          = digitalocean_vpc.kubernetes_vpc.id
  droplet_agent     = true
  graceful_shutdown = true
  ssh_keys          = [digitalocean_ssh_key.droplet_ssh_key.id]
  user_data         = file("${path.module}/startupscripts/masternodesetup.sh")
  tags              = local.common_tags
}