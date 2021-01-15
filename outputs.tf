#Module      : LABLE
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.
output "id" {
  value       = local.id
  description = "Disambiguated ID."
}

output "name" {
  value       = local.name
  description = "Normalized name."
}

output "repository" {
  value       = local.repository
  description = "Terraform current module repo"
}

output "environment" {
  value       = local.environment
  description = "Normalized environment"
}

output "attributes" {
  value       = local.attributes
  description = "Normalized attributes."
}

output "tags" {
  value       = local.tags
  description = "Normalized Tag map."
}
