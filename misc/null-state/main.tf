variable "organization" {
  type = string
}

variable "workspaces" {
  type = string
}

data "terraform_remote_state" "my_output" {
  backend = "remote"
  config = {
    hostname     = "backend.api.env0.com"
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

