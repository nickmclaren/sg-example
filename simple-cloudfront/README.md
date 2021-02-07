# Simple Cloudfront
A module that takes a path to the contents of a static html site and deploys that to an s3 bucket as well creates a cloudfront distribution to serve the site content

## Input Parameters

### cache_behaviors
    description: Cache Behaviors to define for distribution
    type: string
    Optional - default: []

### comment
    description: Comment to apply to Cloudfront Distribution and Origin Access Identity
    type: string
    Optional - default: ""

### invalidation_paths
    description: List of paths to use in running a cloudfront invalidation anytime the site contents changes
    type: list(string)
    Optional - default: []

### name
    description: Name to use in constructing module resources
    type: string
    Required

### price_class
    description:
    type: string
    Optional - default: "PriceClass_100"

### site_content_path
    description: Local path to find site contents
    type: string
    Required

### site_root_object
    description: Root object for cloudfront distribution to serve
    type: string
    Required

### tags
    description: Tags to assign to module created resources
    type: string 
    Optional - default: {}


## Example
```
module "cloudfront_distribution" {
  source   = "./simple-cloudfront"

  name       : "Some Name"
  comment    : "Some Comment"
  invalidation_paths = ["/images/*", "/assets/*"]
  site_content_path  = "${path.modules}/www"
  site_root_object   = "index.html"
  cache_behaviors    = [
    {
        path_pattern = "/assets/"
        min_ttl      = 1800
        default_ttl  = 1800
        max_ttl      = 1800
    }
  ]
  tags       : {
    tag1 = "value1"
    tag2 = "value2"
  }
}
```