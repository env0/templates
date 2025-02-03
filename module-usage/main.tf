
   module "localModule" {
       source = "./local-module"
   }

 module "vpc" {
   source = "git::https://github.com/env0/modules-ci-testing-integration-tests.git?ref=pr-test"
 }

resource "null_resource" "null" {}
