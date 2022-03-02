data "http" "example" {
  url = "https://blabla.free.beeceptor.com/my/api/path"
  # url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"
  # url = "https://dummy-url-blabla-checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

resource "null_resource" "nullAA2" {
}

resource "null_resource" "nullAA" {
  triggers = {
    cluster_instance_ids = data.http.example.body
  }
}
