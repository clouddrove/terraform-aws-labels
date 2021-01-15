module "labels" {
  source = "./../"

  name        = "labels"
  environment = "test"
  label_order = ["environment", "name"]
}
