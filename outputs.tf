output "id" {
  value       = "${local.id}"
  description = "Disambiguated ID"
}

output "name" {
  value       = "${local.name}"
  description = "Normalized name"
}

output "application" {
  value       = "${local.application}"
  description = "Normalized namespace"
}

output "environment" {
  value       = "${local.environment}"
  description = "Normalized stage"
}

output "attributes" {
  value       = "${local.attributes}"
  description = "Normalized attributes"
}

output "tags" {
  value       = "${local.tags}"
  description = "Normalized Tag map"
}
