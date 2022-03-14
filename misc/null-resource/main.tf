resource "null_resource" "null2" {
  count = 2

  attr1 = "hello"
  attr2 = "value"
  
  triggers = {
    tags = "my_tag_2"
  }
}
