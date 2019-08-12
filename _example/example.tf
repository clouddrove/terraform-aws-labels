module "labels" {
  source = "git::https://github.com/clouddrove/terraform-labels.git"

  name        = "labels"
  application = "clouddrove"
  environment = "test"
  label_order = ["name", "application", "environment"]
}
