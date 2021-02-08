variable "cache_behaviors" {
  type = list(object({
    path_pattern = string
    min_ttl      = number
    default_ttl  = number
    max_ttl      = number
  }))
  description = "Cache Behaviors to define for distribution"
  default     = []
}

variable "comment" {
  type        = string
  description = "Comment to apply to Cloudfront Distribution and Origin Access Identity"
  default     = ""
}

variable "invalidation_paths" {
  type        = list(string)
  description = "List of paths to use in running a cloudfront invalidation anytime the site contents changes"
  default     = []
}

variable "name" {
  type        = string
  description = "Name to use in constructing module resources"
}

variable "price_class" {
  type        = string
  description = "Cloudfront price class. Valid Values: PriceClass_100 | PriceClass_200 | PriceClass_All"
  default     = "PriceClass_100"
}

variable "site_content_path" {
  type        = string
  description = "Local path to find site contents"
}

variable "site_root_object" {
  type        = string
  description = "Root object for cloudfront distribution to serve"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to module created resources"
  default     = {}
}
