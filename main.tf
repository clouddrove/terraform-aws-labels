## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

#Module      : locals
#Description : Terraform module to create consistent naming for multiple names.
locals {
  enabled     = "${var.enabled == "true" ? true : false }"
  id          = "${local.enabled == true ? lower(join(var.delimiter, compact(concat(list(var.environment, var.name), var.attributes)))) : ""}"
  name        = "${local.enabled == true ? lower(format("%v", var.name)) : ""}"
  application = "${local.enabled == true ? lower(format("%v", var.application)) : ""}"
  environment = "${local.enabled == true ? lower(format("%v", var.environment)) : ""}"
  createdby   = "${local.enabled == true ? lower(format("%v", var.createdby)) : ""}"
  managedby   = "${local.enabled == true ? lower(format("%v", var.managedby)) : ""}"
  attributes  = "${local.enabled == true ? lower(format("%v", join(var.delimiter, compact(var.attributes)))) : ""}"

  # Merge input tags with our tags.
  # Note: `Name` has a special meaning in AWS and we need to disamgiuate it by using the computed `id`
  tags = "${
      merge(
        map(
          "Name", "${local.id}",
          "Applicatoin", "${local.application}",
          "Environment", "${local.environment}",
          "CreatedBy",   "${local.createdby}",
          "ManagedBy",   "${local.managedby}"
        ), var.tags
      )
    }"
}
