terraform {
  backend "remote" {
    hostname     = "backend-dev.api.dev.env0.com"
    organization = "bd12a04a-b051-4f51-9a8a-8a32ac198802.6b1b0897-5322-48cd-98b7-5e11766f54c8"
    workspaces {
      name = "env05e894e"
    }
  }
}

resource "null_resource" "null" {
}

