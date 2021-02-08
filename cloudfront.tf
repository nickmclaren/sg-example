module "site_cloudfront_distribution" {
  for_each = local.sites
  source   = "./simple-cloudfront"

  name               = each.value["name"]
  comment            = each.value["comment"]
  invalidation_paths = each.value["invalidation_paths"]
  site_content_path  = each.value["site_content_path"]
  site_root_object   = each.value["site_root_object"]
  cache_behaviors    = each.value["cache_behaviors"]
  tags               = local.common_tags
}
