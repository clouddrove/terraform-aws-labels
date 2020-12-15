module "labels" {
  source = "./../"

  name        = "labels"
  module-repo = "clouddrove/terraform-labels"
  label_order = ["name", "module-repo"]
}
