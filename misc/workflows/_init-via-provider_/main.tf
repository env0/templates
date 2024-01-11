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
  name        = "Graph with a leaf dependant by two branches"
  description = <<EOF
                     firstRootFirstDependency
                   /
    firstRoot    -
                   \
                     firstRootSecondDependency -
                                                \
                                                 - leaf
                                                /
    secondRoot  -    secondRootFirstDependency -
  EOF
  repository  = "https://github.com/env0/templates"
  path        = "misc/workflows/graph-with-leaf-dependant-on-two-branches"
  type        = "workflow"
  revision    = "master"
}

resource "env0_configuration_variable" "workspace_name_variable" {
  name        = "WORKSPACE_NAME"
  value       = "my-wf-prefix"
  type = "environment"
  template_id = env0_template.complex_workflow.id
}

resource "env0_template_project_assignment" "complex_assignment" {
  template_id = env0_template.complex_workflow.id
  project_id  = env0_project.workflows_project.id
}

data "env0_template" "complex_workflow" {
  name = "Graph with a leaf dependant by two branches"
}

resource "env0_environment" "workflow_environment" {
  depends_on                 = [env0_template_project_assignment.complex_assignment]
  name                       = "workflow-env"
  project_id                 = env0_project.workflows_project.id
  template_id                = env0_template.complex_workflow.id
  approve_plan_automatically = true
  revision = data.env0_template.complex_workflow.revision # todo: ask/ticket about revision ("") change not make actual change, nor environment doesnt refresh revision from template
}
