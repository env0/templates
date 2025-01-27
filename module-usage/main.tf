
module "Random" {
  source = "api-dev.dev.env0.com/bd12a04a-b051-4f51-9a8a-8a32ac198802/Random/env0"
  version = "1.0.0"
}

module "moduleName" {
  source = "api-pr18034.dev.env0.com/fe2a0403-6dc5-4897-913e-9d3efc97473a/moduleName/provider"
  version = "1.0.0"
}

resource "null_resource" "null" {}
