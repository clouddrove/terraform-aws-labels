module "labels" {
  source = "./../"

  name        = "labels"
  module-repo = "git::https://github.com/clouddrove/terraform-labels.git"
  label_order = ["name", "module-repo"]
}
