locals {
  compare     = "success"
  testSuccess = "success"
  testFail    = "fail"
}

module "errorcheck_valid" {
  source = "rhythmictech/errorcheck/terraform"

  assert = local.compare == local.testSuccess
  error_message = "Your assertion is not valid"
}

module "errorcheck_invalid" {
  source = "rhythmictech/errorcheck/terraform"

  assert = local.compare == local.testFail
  error_message = "Your assertion is not valid"
}