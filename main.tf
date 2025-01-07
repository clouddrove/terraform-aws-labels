## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

# Module      : locals
# Description : This terraform module is designed to generate consistent label names and tags 
#               for resources. You can use terraform-labels to implement a strict naming convention.

locals {
  enabled = var.enabled == true ? true : false

  # Context for labels
  id_context = {
    name        = var.name
    application = var.application
    environment = var.environment
  }

  # Set label order and loop through for generating labels
  label_order = length(var.label_order) > 0 ? var.label_order : ["environment", "application", "name"]
  id_labels   = [for l in local.label_order : local.id_context[l] if length(local.id_context[l]) > 0]

  # Generate id and other labels
  id          = local.enabled ? lower(join(var.delimiter, local.id_labels, var.attributes)) : ""
  name        = local.enabled ? lower(format("%v", var.name)) : ""
  application = local.enabled ? lower(format("%v", var.application)) : ""
  environment = local.enabled ? lower(format("%v", var.environment)) : ""
  createdby   = local.enabled ? lower(format("%v", var.createdby)) : ""
  managedby   = local.enabled ? lower(format("%v", var.managedby)) : ""
  attributes  = local.enabled ? lower(format("%v", join(var.delimiter, compact(var.attributes)))) : ""
  repository  = local.enabled ? lower(format("%v", var.repository)) : ""

  # Tags context for additional flexibility
  tags_context = {
    name        = local.id
    application = local.application
    environment = local.environment
    createdby   = local.createdby
    managedby   = local.managedby
    repository  = local.repository
  }

  # Generate dynamic tags based on context
  generated_tags = { for k, v in local.tags_context : title(k) => v if length(v) > 0 }

  # Merge generated tags with additional user-provided tags
  tags = local.enabled ? merge(local.generated_tags, var.extra_tags) : null
}
