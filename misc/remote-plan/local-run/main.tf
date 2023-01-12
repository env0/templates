terraform {
  backend "remote" {
    hostname     = "backend-bors.api.dev.env0.com"
    organization = "214afc56-607b-447a-a533-5f3f6d608539.cf955e20-a57d-4446-9821-7aed8e3b4edb"
    workspaces {
      name = "remote-plan-it"
    }
  }
}

resource "null_resource" "branch2" {
  count = 2
}
