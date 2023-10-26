module "labels" {
  source = "./../"

  enabled     = true
  name        = "labels"
  environment = "test"
  label_order = ["name", "environment"]
  attributes  = ["private"]
  extra_tags = {
    Application = "CloudDrove"
  }
}
