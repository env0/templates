data "aws_iam_policy_document" "bucket_access" {
  statement {
    sid = "DefaultS3"
    actions = [
      "s3:*Object",
      "s3:GetObjectVersion",
      "s3:GetBucketLocation",
      "s3:ListBucket"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
  statement {
    sid = "ListAllMyBuckets"
    actions = [
      "s3:ListAllMyBuckets"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::*",
    ]
  }
  statement {
    sid = "KMSAccess"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    effect = "Allow"
    resources = [
      aws_kms_key.key.arn
    ]
  }
}

data "aws_iam_policy_document" "bucket_policy" {
  # https://blog.quigley.codes/merging-iam-in-terraform/
  # SIDs have to match in order to actually override any statements. Otherwise they will be merged.
  override_json = var.bucket_policy_override
  statement {
    sid = "PutBucketConstraint"
    actions = [
      "s3:PutObject"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    effect = "Deny"
    resources = [
      "arn:${data.aws_partition.current.partition}:s3:::${var.bucket_name}/*",
    ]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        ""
      ]
    }
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption-aws-kms-key-id"
      values = [
        aws_kms_key.key.arn
      ]
    }
  }
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "bucket_access" {
  name = "${var.bucket_name}-access"
  policy = data.aws_iam_policy_document.bucket_access.json
}

data "aws_iam_role" "service_roles" {
  for_each = var.service_roles
  name     = each.value.name
}

resource "aws_iam_role_policy_attachment" "bucket_access" {
  for_each   = data.aws_iam_role.service_roles
  role       = each.value.name
  policy_arn = aws_iam_policy.bucket_access.arn
}

resource "aws_kms_key" "key" {
  description = var.kms_key_description
  tags = var.tags
  enable_key_rotation = true
  deletion_window_in_days = "${ coalesce(var.kms_deletion_window_in_days, 7) }"
}

resource "aws_kms_alias" "kms_key_alias" {
  name = "alias/victor-s3/${lower(var.bucket_name)}"
  target_key_id = aws_kms_key.key.key_id
}

resource "aws_s3_bucket_policy" "demo-policy" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.bucket_policy.json
}


module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 2.1.0"
  bucket  = var.bucket_name
  acl     = "private"
  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled  = true
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.key.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  lifecycle_rule = [
    {
      id      = "expire"
      enabled = var.expiration_days == 0 ? false : true
      expiration = {
        days = var.expiration_days
      }
      noncurrent_version_expiration = {
        days = 7
      }
    }
  ]
}

resource "aws_ssm_parameter" "bucket_name" {
  count = var.param_for_bucket_name != "" ? 1 : 0

  name  = var.param_for_bucket_name
  type  = "String"
  value = module.s3_bucket.s3_bucket_id
}

output "bucket_arn" {
  value = module.s3_bucket.s3_bucket_arn
}

output "roles_with_access" {
  value = var.service_roles
}
