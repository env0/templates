
module "env0-agent-gcp" {
  source = "api-dev.dev.env0.com/bd12a04a-b051-4f51-9a8a-8a32ac198802/env0-agent-gcp/env0"
  version = "1.0.0"
}

resource "null_resource" "null" {}
