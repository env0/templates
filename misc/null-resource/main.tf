resource "null_resource" "null" {
  count = 2

  triggers = {
    tags = "my_tag_2"
  }
}
