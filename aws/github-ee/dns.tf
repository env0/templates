resource "aws_route53_record" "github-ee-record" {
  name    = var.dns_name
  type    = "A"
  zone_id = var.aws_route53_zone_id
  ttl     = "300"
  records = [aws_instance.github_ee.public_ip]
}
