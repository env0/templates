variable "env0_api_key" {
	type = string
}

variable "env0_api_secret" {
	type = string
 }

variable "environments_amount" {
	type = number
}

terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
  api_key = 				var.env0_api_key
  api_secret = 			var.env0_api_secret
	api_endpoint = 		https://api-dev.dev.env0.com
	organization_id = f4227bc9-0a36-4608-848c-a234394ed3cc
}

resource "env0_template" "null_template" {
  name        = "null template provider"
  repository  = "https://github.com/env0/templates"
  path        = "misc/null-resource"
}

resource "env0_project" "provider_project" {
  name = "Provider Project"
}

resource "env0_template_project_assignment" "assignment" {
  template_id = env0_template.null_template.id
  project_id  = env0_project.provider_project.id
}

resource "env0_environment" "example" {
	count 			= var.environments_amount
  name        = "environment"
  project_id  = env0_project.provider_project.id
  template_id = env0_template.null_template.id
}