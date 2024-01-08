resource "null_resource" "null" {
}

module "aaa3" {
  source  = "api-pr14408.dev.env0.com/2db1209f-7646-46b6-aafc-b7c9f34ea9f6/templates-test/templatestest"
  version = "pref/5.0.0-alpha.1"
}