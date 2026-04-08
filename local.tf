locals {
  project_code = lower(var.project_name)
  common_tags = [
    "Project: ${var.project_name}",
    "CreatedOn: ${formatdate("YYYY-MM-DD", timestamp())}"
  ]
}