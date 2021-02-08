module "cloudfront_codepipeline" {
  source                = "github.com/StratusGrid/terraform-aws-codepipeline-iac"
  name                  = "${var.name_prefix}-jrlew${local.name_suffix}"
  cp_tf_manual_approval = [true]
  codebuild_iam_policy  = local.cloudfront_codebuild_policy
  cb_env_compute_type   = "BUILD_GENERAL1_SMALL"
  cb_env_image          = "aws/codebuild/standard:2.0"
  cb_env_type           = "LINUX_CONTAINER"
  cb_tf_version         = "0.13.4"
  cb_env_name           = var.env_name
  cp_source_oauth_token = var.github_access_token
  cp_source_owner       = "jrlew"
  cp_source_repo        = "sg-example"
  cp_source_branch      = var.env_name

  cb_env_image_pull_credentials_type = "CODEBUILD"
  cp_source_poll_for_changes         = true
  input_tags                         = local.common_tags
}

locals {
  backend_name   = "terraform-backend"
  s3_bucket_name = "terraform-backend-jrlew"

  cloudfront_codebuild_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::${local.s3_bucket_name}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::${local.s3_bucket_name}/funicom-delivery-static-${var.env_name}.tfstate"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/${local.backend_name}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "${module.cloudfront_codepipeline.codepipeline_resources_bucket_arn}",
                "${module.cloudfront_codepipeline.codepipeline_resources_bucket_arn}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:Describe*",
                "kms:Get*",
                "kms:List*",
                "iam:*",
                "codepipeline:*",
                "codebuild:*",
                "codedeploy:*",
                "cloudfront:*",
                "s3:*",
                "lambda:*",
                "apigateway:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
POLICY
}