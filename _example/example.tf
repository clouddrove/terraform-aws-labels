module "labels" {
  source = "./../"

  name        = "labels"
  repository  = "https://github.com/clouddrove/terraform-labels"
  environment = "test"
  label_order = ["environment", "name"]
}
