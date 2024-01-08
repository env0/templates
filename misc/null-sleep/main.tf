resource "null_resource" "null" {
}

module "aaa3" {
  source  = "api-dev.dev.env0.com/63c723d4-5a73-491e-b187-ad4963914c46/aaa3/aaa3"
  version = "pref/5.0.0-alpha.1"
}