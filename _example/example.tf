module "labels" {
  source = "./../"

  name        = "labels"
  environment = "test"
  attributes  = ["public"]
  label_order = ["environment", "name", "attributes"]
  terraform_version_tag = true
  timestamp_tag = true
}
