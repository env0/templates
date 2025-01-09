module "env0" {
  source  = "app.terraform.io/tomer123/env0/provider"
  version = "1.0.0"
}
module "Random" {
  source = "api-dev.dev.env0.com/bd12a04a-b051-4f51-9a8a-8a32ac198802/Random/env0"
  version = "1.0.0"
}

resource "null_resource" "null" {}
