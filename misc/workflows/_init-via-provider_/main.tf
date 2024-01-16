terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.10.0"
    }
    env = {
      source  = "tchupp/env"
      version = "0.0.2"
    }
  }
}

provider "env0" {
  # no need to provide props here, we use environment variables for
}

provider "time" {}

provider "env" {}

resource "env0_project" "workflows_project" {
  name = "workflows"
}

// workflow file in `complex_workflow` use this null template
resource "env0_template" "null_template" {
  name              = "null"
  repository        = local.repository
  revision          = local.revision
  path              = "misc/null-resource"
  type              = "terraform"
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
  path        = "misc/workflows/graph-with-leaf-dependant-on-two-branches"
  type        = "workflow"
  repository  = local.repository
  revision    = local.revision
}

resource "env0_configuration_variable" "workspace_name_variable" {
  name        = "WORKSPACE_NAME"
  value       = var.workspace_prefix
  type        = "environment"
  template_id = env0_template.complex_workflow.id
}

resource "env0_template_project_assignment" "complex_assignment" {
  template_id = env0_template.complex_workflow.id
  project_id  = env0_project.workflows_project.id
}

resource "time_sleep" "wait_for_template" {
  depends_on       = [env0_template.complex_workflow]
  destroy_duration = "3s"
}

data "env0_template" "complex_workflow" {
  depends_on = [time_sleep.wait_for_template]
  name       = "Graph with a leaf dependant by two branches"
}

resource "env0_environment" "workflow_environment" {
  depends_on                 = [env0_template_project_assignment.complex_assignment]
  name                       = "workflow-env"
  project_id                 = env0_project.workflows_project.id
  template_id                = env0_template.complex_workflow.id
  approve_plan_automatically = true
  revision                   = data.env0_template.complex_workflow.revision  # todo: ask/ticket about revision ("") change not make actual change, nor environment doesnt refresh revision from template
}
