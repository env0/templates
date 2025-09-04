# IAM Roles - Codified from Click-Ops managed resources
# Generated from env0 cloud resources discovery

# Bedrock Knowledge Base Execution Role - Avner Test Schema
import {
  to = aws_iam_role.bedrock_kb_role_avner_test
  id = "AmazonBedrockExecutionRoleForKnowledgeBase_avner_test_schema"
}

resource "aws_iam_role" "bedrock_kb_role_avner_test" {
  name        = "AmazonBedrockExecutionRoleForKnowledgeBase_avner_test_schema"
  path        = "/service-role/"
  description = "Bedrock Knowledge Base access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AmazonBedrockKnowledgeBaseTrustPolicy"
        Effect = "Allow"
        Principal = {
          Service = "bedrock.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = "326535729404"
          }
          ArnLike = {
            "aws:SourceArn" = "arn:aws:bedrock:us-east-1:326535729404:knowledge-base/*"
          }
        }
      }
    ]
  })
}

# Bedrock Knowledge Base Execution Role - Y0V5W
import {
  to = aws_iam_role.bedrock_kb_role_y0v5w
  id = "AmazonBedrockExecutionRoleForKnowledgeBase_y0v5w"
}

resource "aws_iam_role" "bedrock_kb_role_y0v5w" {
  name        = "AmazonBedrockExecutionRoleForKnowledgeBase_y0v5w"
  path        = "/service-role/"
  description = "Bedrock Knowledge Base access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "TrustPolicyStatement"
        Effect = "Allow"
        Principal = {
          Service = "bedrock.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = "326535729404"
          }
          ArnLike = {
            "aws:SourceArn" = "arn:aws:bedrock:us-east-1:326535729404:knowledge-base/*"
          }
        }
      }
    ]
  })
}

# Yariv Admin Role
import {
  to = aws_iam_role.yariv_admin
  id = "aws-role-yariv-admin"
}

resource "aws_iam_role" "yariv_admin" {
  name                 = "aws-role-yariv-admin"
  max_session_duration = 18000
  description          = ""
}

# DSAF Lambda Execution Role
import {
  to = aws_iam_role.dsaf_role
  id = "dsaf-role-g3hxf9mo"
}

resource "aws_iam_role" "dsaf_role" {
  name = "dsaf-role-g3hxf9mo"
  path = "/service-role/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Assumed Role by Prod Admin
import {
  to = aws_iam_role.assumed_role_prod_admin
  id = "assumed-role-by-prod-admin"
}

resource "aws_iam_role" "assumed_role_prod_admin" {
  name        = "assumed-role-by-prod-admin"
  description = ""
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          AWS = "170412844252"
        }
        Condition = {
          StringEquals = {
            "sts:ExternalId" = "sdsd"
          }
        }
      }
    ]
  })
}
