terraform {
  required_providers {
    env0 = {
      version = "6.6.6"
      source  = "terraform.env0.com/local/env0"
    }
  }
}

provider "env0" {
  api_key    = var.env0_api_key    # or use ENV0_API_KEY
  api_secret = var.env0_api_secret # or use ENV0_API_SECRET
  api_endpoint = "https://api-dev.dev.env0.com"
}

data "env0_template" "example" {
  name = "GitHub Hever"
}

data "env0_project" "default_project" {
  name = "Hever"
}

resource "env0_environment" "example" {
  name        = "environment - TF"
  project_id  = data.env0_project.default_project.id
  template_id = data.env0_template.example.id
  force_destroy = true
  approve_plan_automatically = true
}