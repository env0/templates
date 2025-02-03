
#   module "localModule" {
#       source = "./local-module"
#   }
module "namename" {
  source = "api-pr18106.dev.env0.com/daa05acb-6df8-40bb-aab2-6949af64026f/namename/providerer"
  version = "0.0.2"
}


 module "vpc" {
   source = "git::https://github.com/env0/modules-ci-testing-integration-tests.git?ref=pr-test"
 }

resource "null_resource" "null" {}
