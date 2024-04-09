terraform {
  required_version = "~> 1.5.7"
  backend "remote" {
    hostname = "backend-pr15085.api.dev.env0.com"
    organization = "5d9dd941-aa90-4f82-a38a-04ac76d15692.f754b8f3-eeca-47b9-af03-cdfe1c32c0b6"

    workspaces {
      name = "eks-upgrade-test"
    }
  }
}

resource "null_resource" "null" {
}
// 0ms1Z2BULrpq0QSTDXODNrEzDnMiJgtw
// cGF1bXp4dmFyajd5Z2N zdDpld2pWR2ZkWmdnSjJrZm9QZVotd29QQnI4VWpqUFMxdQ==