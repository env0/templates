resource "random_string" "external_id" {
    length      = 32
    upper       = true
    min_upper   = 1
    lower       = true
    min_lower   = 1
    numeric     = true
    min_numeric = 1
    special     = false
}


resource "aws_iam_policy" "env0_cost" {
    name        = "env0_cost"
    path        = "/"
    description = "env0_cost"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ce:GetCostAndUsage",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "env0_cost" {
    name = "env0_cost"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::913128560467:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals" : {
                    "sts:ExternalId" : "${random_string.external_id.result}"
                }
            }
        }
    ]
}
EOF

    permissions_boundary = null
}

resource "aws_iam_role_policy" "env0_cost_policy" {
    name = "env0_cost_policy"
    role = aws_iam_role.env0_cost.id

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ce:GetCostAndUsage",
                "ce:GetCostForecast"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "allow_env0_cost" {
    role       = aws_iam_role.env0_cost.name
    policy_arn = aws_iam_policy.env0_cost.arn
}