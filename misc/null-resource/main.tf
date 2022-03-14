resource "null_resource" "null2" {
  count = 2

  triggers = {
    tags = "my_tag_2"
  }
}

resource "null_resource" "null" {
  triggers = {
    tags = "my_tag_1"
  }
}
