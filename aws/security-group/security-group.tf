module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  name = "some group"
  version = "4.8.0"
}
