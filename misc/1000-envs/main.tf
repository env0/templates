terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

# Configure the env0 provider
provider "env0" {
  api_key    = "dhyumntownro11ur"
  api_secret = "yy2_vbKfbzGGASxXxFl-1YM6aOWpTZW8"
  organization_id = "19c7c74c-9fc1-4787-a5c9-17699c7dbcbc"
  api_endpoint = "https://api-dev.dev.env0.com"
}

locals {
  project_count = 1000
}

# Create the 1000 projects
resource "env0_project" "project" {
  count = local.project_count
  force_destroy = true
  name        = "Project-${count.index + 1}"
  description = "Project ${count.index + 1} created using Terraform"
}

# Create a single template
resource "env0_template" "template" {
  name        = "null_resource_1"
  repository  = "https://github.com/orr-levinger/env-templates-fork"
  path        = "misc/null-resource"
  github_installation_id = 31621691
}

# Assign the template to all projects
resource "env0_template_project_assignment" "assignment" {
  count = local.project_count

  project_id  = env0_project.project[count.index].id
  template_id = env0_template.template.id
}

# Create one environment in each project
resource "env0_environment" "environment" {
  depends_on = [env0_template_project_assignment.assignment]
  count = local.project_count
  approve_plan_automatically = true
  force_destroy = true
  name        = "Environment-${count.index + 1}"
  project_id  = env0_project.project[count.index].id
  template_id = env0_template.template.id
}