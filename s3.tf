resource "aws_s3_bucket" "site_source" {
  bucket = "${var.name_prefix}-site-source${local.name_suffix}"
  acl    = "private"

  tags = local.common_tags
}

data "archive_file" "site_archive" {
  type        = "zip"
  source_dir = "www/"
  output_path = "www.zip"
}

resource "null_resource" "sync_www_to_s3" {
  triggers = {
    src_hash = data.archive_file.site_archive.output_sha
  }

  provisioner "local-exec" {
    command = "aws s3 sync --delete ${path.module}/www s3://${aws_s3_bucket.site_source.id}"
  }
}