resource "aws_eip" "redash-elastic-ip" {
  instance = aws_instance.redash-instance.id
  vpc      = true
}
