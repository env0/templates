locals {
  dim                  = 300
  list_projects_index  = range(local.dim / 6)
  list_templates_index = range(local.dim / 6)
  list_combine = toset(flatten([for i in local.list_projects_index :
    [for j in local.list_templates_index :
      "${i}_${j}"
  ]]))

  lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vitae quam dapibus ipsum venenatis lobortis. Nam eget nunc et sapien porta finibus pulvinar a mauris. Mauris pellentesque nisl in purus faucibus venenatis. Vivamus pharetra ex sit amet ex laoreet luctus. Cras imperdiet convallis erat, sit amet pharetra neque tincidunt ac."
}

terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

variable "env0_api_key" {}
variable "env0_api_secret" {}
variable "env0_api_endpoint" {}

provider "env0" {
  api_key = var.env0_api_key
  api_secret = var.env0_api_secret
  api_endpoint = var.env0_api_endpoint
}

resource "env0_template" "template" {
  count                  = local.dim
  name                   = "template ${count.index}"
  description            = "template #${count.index} - ${local.lorem_ipsum}"
  repository             = "https://github.com/sagilaufer1992/templates"
  path                   = ""
  type                   = "terraform"
  ssh_keys               = []
  github_installation_id = 26581947
}

resource "env0_project" "project" {
  count       = local.dim
  name        = "project ${count.index}"
  description = "project #${count.index} - ${local.lorem_ipsum}"
}

resource "env0_template_project_assignment" "assignment" {
  for_each = local.list_combine

  project_id  = env0_project.project[split("_", each.key)[0]].id
  template_id = env0_template.template[split("_", each.key)[1]].id
}

resource "env0_environment" "environments" {
  count = 500

  name        = "env proj ${floor(count.index / 10)} template ${count.index % 10}"
  project_id  = env0_project.project[floor(count.index / 10)].id
  template_id = env0_template.template[count.index % 10].id
}
