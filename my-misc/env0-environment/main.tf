 terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
  api_key    = var.env0_api_key
  api_secret = var.env0_api_secret
}


resource "env0_environment" "example" {
  name        = "environment"
  project_id  = "6cfc2e22-9faa-4328-bdef-3926f60f71bc"
  

  without_template_settings {
    repository = "https://github.com/alonnoga/templates"
    path = "my-misc/deploy-tf-var"
  }

  configuration {
    name          = "alon"
    type          = "terraform"
    value         = "balon"
    schema_format = "string"
  }
}

