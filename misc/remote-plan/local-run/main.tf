terraform {
  backend "remote" {
    hostname     = "backend-pr10727.api.dev.env0.com"
    organization = "1928f313-c72d-4f85-97a8-44c74858ebda.662ea5e7-14b3-48fc-a3f8-d03c4119dcc4"
    workspaces {
      name = "remote-plan-it3"
    }
  }
}

resource "null_resource" "branch2" {
  count = 2
}

output "t" {
  value = var.r
}
