data "http" "example" {
  url = "https://blabla.free.beeceptor.com/my/api/path"

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
