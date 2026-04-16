locals {
  project_code = lower(var.project_name)
  common_tags = {
    Owner       = "${var.owner}"
    CreatedDate = "${formatdate("DD-MM-YYYY", timestamp())}"
    Project     = "${var.project_name}"
  }
}