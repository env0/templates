
module "moduleName" {
  source = "api-pr18034.dev.env0.com/fe2a0403-6dc5-4897-913e-9d3efc97473a/moduleName/provider"
  version = "1.0.0"
}

module "localModule" {
    source = "./local-module"
}

resource "null_resource" "null" {}
