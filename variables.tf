variable "name" {
  description = "Solution name, e.g. `app`"
}

variable "application" {
  description = "Application name, e.g. `dw` or `CloudDrove`"
}

variable "environment" {
  description = "Environment, e.g. `prod`, `staging`, `dev`, or `test`"
}

variable "createdby" {
  description = "CreatedBy, eg 'terraform'"
  default     = "terraform"
}

variable "managedby" {
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'"
  default     = "anmol@clouddrove.com"
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  default     = "true"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `organization`, `name`, `environment` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes, e.g. `1`"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map(`BusinessUnit`,`XYZ`)"
}
