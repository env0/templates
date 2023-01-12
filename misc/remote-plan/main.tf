terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

resource "env0_api_key" "api_key_sample" {
  name = "name"
}
