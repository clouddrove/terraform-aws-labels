## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

#Module      : locals
#Description : This terraform module is designed to generate consistent label names and tags for resources. You can use terraform-labels to implement a strict naming convention.

locals {
  label_order_defaults = {
    label_order = ["environment", "name"]
  }

  id_context = {
    name        = var.name
    environment = var.environment
  }

  label_order = length(var.label_order) > 0 ? var.label_order : local.label_order_defaults.label_order

  # run loop for label order and set in value.
  id_labels   = [for l in local.label_order : local.id_context[l] if length(local.id_context[l]) > 0 && var.enabled]
  id          = var.enabled ? (var.case_sensitive == true ? join(var.delimiter, local.id_labels, var.attributes) : lower(join(var.delimiter, local.id_labels, var.attributes))) : ""
  name        = var.enabled ? (var.case_sensitive == true ? format("%v", var.name) : lower(format("%v", var.name))) : ""
  environment = var.enabled ? (var.case_sensitive == true ? format("%v", var.environment) : lower(format("%v", var.environment))) : ""
  managedby   = var.enabled ? (var.case_sensitive == true ? format("%v", var.managedby) : lower(format("%v", var.managedby))) : ""
  repository  = var.enabled ? (var.case_sensitive == true ? format("%v", var.repository) : lower(format("%v", var.repository))) : ""
  attributes  = var.enabled ? (var.case_sensitive == true ? format("%v", join(var.delimiter, compact(var.attributes))) : lower(format("%v", join(var.delimiter, compact(var.attributes))))) : ""
  tags_context = {
    # For AWS we need `Name` to be disambiguated sine it has a special meaning
    name        = local.id
    environment = local.environment
    managedby   = local.managedby
    repository  = local.repository
  }

  generated_tags = { for l in keys(local.tags_context) : title(l) => local.tags_context[l] if length(local.tags_context[l]) > 0 }

  tags = var.enabled ? merge(local.generated_tags, var.extra_tags) : null
}
