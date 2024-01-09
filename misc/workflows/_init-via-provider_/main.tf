terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
  #  api_key         = ""                                     // ENV0_API_KEY=
  #  api_secret      = ""                                     // ENV0_API_SECRET=
  #  api_endpoint    = ""                                     // ENV0_API_ENDPOINT=
  #  organization_id = "41890b8e-f15b-464e-9c9a-81e439f33406" // ENV0_ORGANIZATION_ID=41890b8e-f15b-464e-9c9a-81e439f33406
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
  name                       = "workflow-env"
  project_id                 = env0_project.workflows_project.id
  template_id                = env0_template.complex_workflow.id
  approve_plan_automatically = true
}
