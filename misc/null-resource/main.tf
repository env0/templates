resource "null_resource" "null" {
  count = 3

  triggers = {
    tags = 'my_tag'
  }
}
