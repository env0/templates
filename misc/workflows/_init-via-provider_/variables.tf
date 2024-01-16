variable "workspace_prefix" {
  type    = string
  description = "prefix all workspaces of sub-environments nodes"
  default = "my-wf-prefix"
}

variable "revision" {
  type    = string
  description = "revision to clone from (main stream or your fork)"
  default = "master"
}


variable "repository" {
  type    = string
  description = "repository to clone from (main stream or your fork)"
  default  = "https://github.com/env0/templates"
}
