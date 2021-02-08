output "cloudfront_domain_name" {
  description = "Url of created cloudfront distribution"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "name" {
  description = "Name used in constructing module resources"
  value       = var.name
}

output "source_bucket_id" {
  description = "Id of created bucket to hold site source"
  value       = aws_s3_bucket.site_source.id
}
