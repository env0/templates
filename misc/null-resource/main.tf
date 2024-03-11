resource "null_resource" "null" {
}






module "should-fail" {
  source = "api-dev.dev.env0.com/bd12a04a-b051-4f51-9a8a-8a32ac198802/should-fail/elbaz"
  version = "0.0.1"
}
