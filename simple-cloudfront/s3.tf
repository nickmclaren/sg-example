resource "aws_s3_bucket" "site_source" {
  bucket_prefix = substr("${var.name}-site-source", 0, 37)
  acl           = "private"
  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket_policy" "site_source" {
  bucket = aws_s3_bucket.site_source.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "SiteBucketPolicy",
  "Statement": [
    {
      "Sid": "CloudFrontAccess",
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Principal": {
        "AWS": "${aws_cloudfront_origin_access_identity.site_origin_access_identity.iam_arn}"
      },
      "Resource": "${aws_s3_bucket.site_source.arn}/*"
    }
  ]
}
POLICY
}

data "archive_file" "site_archive" {
  type        = "zip"
  source_dir  = var.site_content_path
  output_path = "${var.name}.zip"
}

resource "null_resource" "sync_www_to_s3" {
  triggers = {
    src_hash = data.archive_file.site_archive.output_sha
  }

  provisioner "local-exec" {
    command = "aws s3 sync --delete ${var.site_content_path} s3://${aws_s3_bucket.site_source.id}"
  }
}