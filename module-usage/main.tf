
   module "localModule" {
       source = "./local-module"
   }

module "koko" {
  source = "api-pr18116.dev.env0.com/07f9b973-be64-43e7-84d5-222dfb9da272/koko/loco"
  version = "0.0.2"
}


 module "vpc" {
   source = "git::https://github.com/env0/modules-ci-testing-integration-tests.git?ref=pr-test"
 }

resource "null_resource" "null" {}
