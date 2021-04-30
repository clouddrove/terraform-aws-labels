#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-labels"
  description = "Terraform current module repo"
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources."
  default     = true
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `organization`, `name`, `environment` and `attributes`."
}

variable "context" {
  type = object({
    environment = string
    name        = string
    enabled     = bool
    delimiter   = string
    attributes  = list(string)
    label_order = list(string)
    tags        = map(string)
  })
  default = {
    environment = ""
    name        = ""
    enabled     = true
    delimiter   = ""
    attributes  = []
    label_order = []
    tags        = {}
  }
  description = "Default context to use for passing state between label invocations"
}

variable "terraform_version_tag" {
  type        = bool
  default     = true
  description = "Enable to add Terraform Version dynamic tag"
}

variable "timestamp_tag" {
  type        = bool
  default     = true
  description = "Enable to add Date for creating resources"

}