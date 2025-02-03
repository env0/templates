
#   module "localModule" {
#       source = "./local-module"
#       version = "1.0.0"
#   }

module "vpc" {
  source = "git::https://github.com/env0/modules-ci-testing-integration-tests.git?ref=pr-test"
}

resource "null_resource" "null" {}
