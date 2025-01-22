
module "tf-module" {
  source = "api-pr17961.dev.env0.com/031eac81-1916-4930-9b7c-8c5dab859d0e/tf-module/tomer"
  version = "0.0.2"
}

resource "null_resource" "null" {}
