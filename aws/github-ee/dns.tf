/*
resource "aws_route53_record" "redash-app-dashboard-env0-dot-com-A-record" {
  name    = "github-ee.dev.env0.com"
  type    = "A"
  zone_id = var.aws_route53_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_elb.redash.dns_name
    zone_id                = aws_elb.redash.zone_id
  }
}
*/
