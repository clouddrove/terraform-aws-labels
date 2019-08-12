## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

#Module      : locals
#Description : This terraform module is designed to generate consistent label names and tags #              for resources. You can use terraform-labels to implement a strict naming #              convention.
locals {
  enabled = var.enabled == true ? true : false
  id_context = {
    name        = var.name
    application = var.application
    environment = var.environment
  }

  # run loop for label order and set in value.
  id_labels = [for l in var.label_order : local.id_context[l] if length(local.id_context[l]) > 0]

  id          = lower(join(var.delimiter, local.id_labels, var.attributes))
  name        = local.enabled == true ? lower(format("%v", var.name)) : ""
  application = local.enabled == true ? lower(format("%v", var.application)) : ""
  environment = local.enabled == true ? lower(format("%v", var.environment)) : ""
  createdby   = local.enabled == true ? lower(format("%v", var.createdby)) : ""
  managedby   = local.enabled == true ? lower(format("%v", var.managedby)) : ""
  attributes  = local.enabled == true ? lower(format("%v", join(var.delimiter, compact(var.attributes)))) : ""

  # Merge input tags with our tags.
  # Note: `Name` has a special meaning in AWS and we need to disamgiuate it by using the computed `id`
  tags = merge(
    {
      "Name"        = local.id
      "Application" = local.application
      "Environment" = local.environment
      "CreatedBy"   = local.createdby
      "ManagedBy"   = local.managedby
    },
    var.tags
  )
}