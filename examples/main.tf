module "labels" {
  source = "./../"

  case_sensitive = true
  enabled        = true
  name           = "labels"
  environment    = "test"
  label_order    = ["name", "environment"]
  attributes     = ["private"]
  extra_tags = {
    Application = "CloudDrove"
  }
}
