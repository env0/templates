terraform {
  backend "remote" {
    hostname = "backend.api.env0.com"
    organization = "63c723d4-5a73-491e-b187-ad4963914c46.afc16a7e-ba81-4895-9969-3403e53d26d4"

    workspaces {
      name = "ece396de-5caf-4e0a-8e38-a96dc531ec02"
    }
  }
}

resource "null_resource" "null" {
}
