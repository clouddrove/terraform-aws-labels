## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

#Module      : locals
#Description : This terraform module is designed to generate consistent label names and tags #for resources. You can use terraform-labels to implement a strict naming #convention.

locals {
  defaults = {
    label_order = ["environment", "name", "attributes"]
    delimiter   = "-"
    attributes  = [""]
  }

  id_context = {
    name        = var.name
    environment = var.environment
    attributes  = lower(join(var.delimiter, var.attributes))
  }

  label_order = length(var.label_order) > 0 ? var.label_order : local.defaults.label_order

  # run loop for label order and set in value.
  id_labels = [for l in local.label_order : local.id_context[l] if length(local.id_context[l]) > 0]
  id        = lower(join(var.delimiter, local.id_labels))

  enabled = var.enabled

  name        = var.enabled == true ? lower(format("%v", var.name)) : ""
  environment = var.enabled == true ? lower(format("%v", var.environment)) : ""
  managedby   = var.enabled == true ? lower(format("%v", var.managedby)) : ""
  repository  = var.enabled == true ? lower(format("%v", var.repository)) : ""
  delimiter   = var.enabled == true ? lower(format("%v", var.delimiter)) : ""
  attributes  = var.enabled == true ? lower(format("%v", join(var.delimiter, compact(var.attributes)))) : ""
  tag_version = var.enabled == true ? lower(format("%v", var.tag_version)) : ""

  tags_context = {
    # For AWS we need `Name` to be disambiguated sine it has a special meaning
    name        = local.id
    environment = local.environment
    attributes  = local.id_context.attributes
    managedby   = local.managedby
    repository  = local.repository
    tag_version = local.tag_version
  }

  generated_tags = { for l in keys(local.tags_context) : title(l) => local.tags_context[l] if length(local.tags_context[l]) > 0 }

  tags = merge(var.context.tags, local.generated_tags, var.tags)


  output_context = {
    enabled     = local.enabled
    name        = local.name
    environment = local.environment
    attributes  = local.attributes
    tags        = local.tags
    delimiter   = local.delimiter
    label_order = local.label_order
    managedby   = local.managedby
    repository  = local.repository
    tag_version = local.tag_version
  }

}
