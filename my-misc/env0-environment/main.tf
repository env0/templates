 terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

variable "env0_api_key" {
  type = string
}

variable "env0_api_secret" {
  type = string
}

provider "env0" {
  api_key    = var.env0_api_key
  api_secret = var.env0_api_secret
}


resource "env0_environment" "example" {
  name        = "environment"
  project_id  = "68bd374b-828d-478a-bd13-fe005edac05d"
  

  without_template_settings {
    repository = "https://github.com/alonnoga/templates"
    path = "my-misc/deploy-tf-var"
  }

  configuration {
    name          = "SOMETHING"
    type          = "terraform"
    value         = "balon"
    schema_type = "string"
  }
}

