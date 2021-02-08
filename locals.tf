#If no override_name_suffix, then use the combination of prepend_name_suffix, env_name, and append_name_suffix values for suffix.
locals {
  name_suffix = coalesce(var.override_name_suffix, "${var.prepend_name_suffix}-${var.env_name}${var.append_name_suffix}")

  sites = {
    story_time = {
      name               = "${var.name_prefix}${local.name_suffix}-story-time"
      comment            = "Story Time Example Distribution - ${var.env_name}"
      invalidation_paths = ["/images/*", "/assets/*"]
      site_content_path  = "${path.module}/www/story-time"
      site_root_object   = "index.html"
      cache_behaviors = [
        {
          path_pattern = "/images/"
          min_ttl      = 1800
          default_ttl  = 1800
          max_ttl      = 1800
        }
      ]
    },
    hedberg = {
      name               = "${var.name_prefix}${local.name_suffix}-hedberg"
      comment            = "Hedberg Example Distribution - ${var.env_name}"
      invalidation_paths = ["/images/*"]
      site_content_path  = "${path.module}/www/hedberg"
      site_root_object   = "index.html"
      cache_behaviors    = []
    }
  }
}

