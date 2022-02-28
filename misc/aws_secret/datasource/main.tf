data "aws_secretsmanager_secret" "secret" {
  name = "liron-example-name"
}


resource "null_resource" "null" {
  triggers = {
    cluster_instance_ids = join(",", data.aws_secretsmanager_secret.secret.tags)
  }
}
