resource "aws_cloudfront_origin_access_identity" "site_origin_access_identity" {
  comment = var.comment
}

resource "aws_cloudfront_distribution" "site" {
  origin {
    domain_name = aws_s3_bucket.site_source.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.site_origin_access_identity.cloudfront_access_identity_path
    }
  }

  comment             = var.comment
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.site_root_object
  price_class         = var.price_class

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.cache_behaviors

    content {
      path_pattern     = ordered_cache_behavior.value["path_pattern"]
      allowed_methods  = ["GET", "HEAD", "OPTIONS"]
      cached_methods   = ["GET", "HEAD", "OPTIONS"]
      target_origin_id = local.s3_origin_id

      forwarded_values {
        query_string = false
        headers      = ["Origin"]

        cookies {
          forward = "none"
        }
      }

      min_ttl                = ordered_cache_behavior.value["min_ttl"]
      default_ttl            = ordered_cache_behavior.value["default_ttl"]
      max_ttl                = ordered_cache_behavior.value["max_ttl"]
      compress               = true
      viewer_protocol_policy = "redirect-to-https"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "ES"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = var.tags
}

resource "null_resource" "invalidate_www_changes" {
  triggers = {
    src_hash = data.archive_file.site_archive.output_sha
  }

  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.site.id} ${local.invalidation_param}"
  }

  depends_on = [null_resource.sync_www_to_s3]
}
