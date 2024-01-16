data "env_variable" "env0_template_revision" {
  name = "ENV0_TEMPLATE_REVISION"
}

data "env_variable" "env0_deployment_revision" {
  name = "ENV0_DEPLOYMENT_REVISION"
}

data "env_variable" "env0_template_repository" {
  name = "ENV0_TEMPLATE_REPOSITORY"
}

variable "workspace_prefix" {
  type        = string
  description = "prefix all workspaces of sub-environments nodes"
  default     = "my-wf-prefix"
}

locals {
  revision   = data.env_variable.env0_deployment_revision.value != "" ? data.env_variable.env0_deployment_revision.value : data.env_variable.env0_template_revision.value !=  "" ? data.env_variable.env0_template_revision.value : "master"
  repository = data.env_variable.env0_template_repository.value != "" ? data.env_variable.env0_template_repository.value : "https://github.com/env0/templates"
}
