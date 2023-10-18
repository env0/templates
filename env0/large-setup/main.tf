terraform {
  required_version = "1.5.7"
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "1.15.0"
    }
  }
}

variable "env0_api_endpoint" {}
variable "env0_api_key" {}
variable "env0_api_secret" {}

provider "env0" {
  api_endpoint = var.env0_api_endpoint
  api_key      = var.env0_api_key
  api_secret   = var.env0_api_secret
}

resource "env0_template" "my_template" {
  name       = "null template"
  repository = "https://github.com/env0/templates"
  path       = "misc/null-resource"
}

module "module_name" {
  count       = 400
  source      = "./project-module"
  index       = count.index
  template_id = env0_template.my_template.id
}

