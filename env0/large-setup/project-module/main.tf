terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "1.15.0"
    }
  }
}

variable "index" {
  type = number
}

variable "template_id" {}

resource "env0_project" "default_project" {
  name        = "My Project ${var.index}"
  description = "Very Long DEscription, Very Long DEscription, Very Long DEscription ,Very Long DEscription ,Very Long DEscription ,Very Long DEscriptionVery Long DEscription, Very Long DEscription, Very Long DEscription ,Very Long DEscription ,Very Long DEscription ,Very Long DEscriptionVery Long DEscription, Very Long DEscription, Very Long DEscription ,Very Long DEscription ,Very Long DEscription ,Very Long DEscriptionVery Long DEscription, Very Long DEscription, Very Long DEscription ,Very Long DEscription ,Very Long DEscription ,Very Long DEscriptionVery Long DEscription, Very Long DEscription, Very Long DEscription ,Very Long DEscription ,Very Long DEscription ,Very Long DEscription"
}

resource "env0_template_project_assignment" "assignment" {
  template_id = var.template_id
  project_id  = env0_project.default_project.id
}

resource "env0_project" "sub_project_1" {
  name              = "Sub Project ${var.index}-1"
  parent_project_id = env0_project.default_project.id
}

resource "env0_project" "sub_project_2" {
  name              = "Sub Project ${var.index}-2"
  parent_project_id = env0_project.sub_project_1.id
}

resource "env0_environment" "example" {
  name                       = "my environment ${var.index} 1"
  project_id                 = env0_project.default_project.id
  template_id                = var.template_id
  approve_plan_automatically = true
}
