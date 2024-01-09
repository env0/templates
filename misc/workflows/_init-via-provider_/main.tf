terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
  # no need to provide props here, we use environment variables for
}

resource "env0_project" "workflows_project" {
  name = "workflows"
}

// workflow file in `complex_workflow` use this null template
resource "env0_template" "null_template" {
  name        = "null"
  repository  = "https://github.com/env0/templates"
  path        = "misc/null-resource"
  type = "terraform"
  terraform_version = "1.5.7"
}

resource "env0_template_project_assignment" "null_assignment" {
  template_id = env0_template.null_template.id
  project_id  = env0_project.workflows_project.id
}

resource "env0_template" "complex_workflow" {
  name        = "Complex Workflow"
  repository  = "https://github.com/sagydr/env0_templates"
  path        = "misc/workflow-environment-rich-graph"
  revision    = "sagy/workflow"
  type        = "workflow"
}

resource "env0_configuration_variable" "workspace_name_variable" {
  name        = "WORKSPACE_NAME"
  value       = "somevalue"
  template_id = env0_template.complex_workflow.id
  type = "terraform"
}

variable "WORKSPACE_NAME" {
  type    = string
  default = "test"
}

resource "env0_template_project_assignment" "complex_assignment" {
  template_id = env0_template.complex_workflow.id
  project_id  = env0_project.workflows_project.id
}

resource "env0_environment" "workflow_environment" {
  depends_on                 = [env0_template_project_assignment.complex_assignment]
  name                       = "workflow-env"
  project_id                 = env0_project.workflows_project.id
  template_id                = env0_template.complex_workflow.id
  approve_plan_automatically = true
}