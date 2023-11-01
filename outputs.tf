#Module      : LABLE
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.
output "id" {
  value       = try(local.id, null)
  description = "Disambiguated ID."
}

output "name" {
  value       = try(local.name, null)
  description = "Normalized name."
}

output "repository" {
  value       = try(local.repository, null)
  description = "Terraform current module repo"
}

output "environment" {
  value       = try(local.environment, null)
  description = "Normalized environment"
}

output "attributes" {
  value       = try(local.attributes, null)
  description = "Normalized attributes."
}

output "tags" {
  value       = try(local.tags, null)
  description = "Normalized Tag map."
}

output "label_order" {
  value       = try(local.label_order, null)
  description = "Normalized Tag map."
}
