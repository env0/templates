
#   module "localModule" {
#       source = "./local-module"
#   }

module "koko" {
  source = "api-pr18106.dev.env0.com/c53a8298-4679-433c-906e-b4d527710258/koko/lcoc"
  version = "0.0.2"
}

 module "vpc" {
   source = "git::https://github.com/env0/modules-ci-testing-integration-tests.git?ref=pr-test"
 }

resource "null_resource" "null" {}
