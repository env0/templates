output "account_id" {
    value = data.aws_caller_identity.current.account_id
}

output "env0_cost_external_id" {
    value = random_string.external_id.result
}

output "env0_cost_role_arn" {
    value = aws_iam_role.env0_cost.arn
}