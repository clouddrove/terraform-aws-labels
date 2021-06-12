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
  id_labels = [for l in local.label_order : local.id_context[l] if length(local.id_context[l]) > 0]
  id        = lower(join(var.delimiter, local.id_labels, var.attributes))

  enabled = var.enabled

  name        = var.enabled == true ? lower(format("%v", var.name)) : ""
  environment = var.enabled == true ? lower(format("%v", var.environment)) : ""
  managedby   = var.enabled == true ? lower(format("%v", var.managedby)) : ""
  repository  = var.enabled == true ? lower(format("%v", var.repository)) : ""
  delimiter   = var.enabled == true ? lower(format("%v", var.delimiter)) : ""
  attributes  = var.enabled == true ? lower(format("%v", join(var.delimiter, compact(var.attributes)))) : ""

  tags_context = {
    # For AWS we need `Name` to be disambiguated sine it has a special meaning
    name        = local.id
    environment = local.environment
    managedby   = local.managedby
    repository  = local.repository
  }

  generated_tags = { for l in keys(local.tags_context) : title(l) => local.tags_context[l] if length(local.tags_context[l]) > 0 }

  tags = merge(local.generated_tags, var.extra_tags)
}
