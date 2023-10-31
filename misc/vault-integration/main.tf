provider "vault" {
  address = "http://ab2fe5d8c6c3642cf893184fc93d6be7-1541439417.us-east-1.elb.amazonaws.com:8200/"
  auth_login_jwt {
    namespace = "admin"
    role = "bors-env0-integration-tests-role"
  }
}

resource "null_resource" "null" {
}
