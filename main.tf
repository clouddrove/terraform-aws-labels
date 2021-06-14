## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

#Module      : locals
#Description : This terraform module is designed to generate consistent label names and tags for resources. You can use terraform-labels to implement a strict naming convention.

resource "null_resource" "cmd" {
  provisioner "local-exec" {
    command = "terraform version -json > ${path.module}/terraform.json"
  }

}

data "local_file" "get_terrraform_version" {
  filename   = "${path.module}/terraform.json"
  depends_on = [null_resource.cmd]
}

locals {
  triggers = {
    order = null_resource.cmd.id
  }
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

  name              = var.enabled == true ? lower(format("%v", var.name)) : ""
  environment       = var.enabled == true ? lower(format("%v", var.environment)) : ""
  managedby         = var.enabled == true ? lower(format("%v", var.managedby)) : ""
  repository        = var.enabled == true ? lower(format("%v", var.repository)) : ""
  delimiter         = var.enabled == true ? lower(format("%v", var.delimiter)) : ""
  attributes        = var.enabled == true ? lower(format("%v", join(var.delimiter, compact(var.attributes)))) : ""
  terraform_version = (var.terraform_version_tag == true && fileexists("${path.module}/terraform.json")) ? jsondecode(file("${path.module}/terraform.json")).terraform_version : ""
  timestamp         = var.timestamp == true ? formatdate("DD MMM YYYY ZZZ", "${timestamp()}") : ""

  tags_context = {
    # For AWS we need `Name` to be disambiguated sine it has == truea special meaning
    name              = local.id
    environment       = local.environment
    attributes        = local.id_context.attributes
    managedby         = local.managedby
    repository        = local.repository
    terraform_version = local.terraform_version
    timestamp         = local.timestamp
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
  }

}
