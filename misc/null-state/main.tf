variable "organization" {
  type = string
}

variable "workspaces" {
  type = string
}

variable "backend" {
  type = string
  default = "backend-dev.api.dev.env0.com"
}

data "terraform_remote_state" "my_output" {
  backend = "remote"
  config = {
    hostname     = var.backend
    organization = var.organization
    workspaces = {
      name = var.workspaces
    }
  }
}


resource "null_resource" "null" {
  count = data.terraform_remote_state.my_output.outputs.my_count

  triggers = {
    new_text = data.terraform_remote_state.my_output.outputs.my_value
  }
}

