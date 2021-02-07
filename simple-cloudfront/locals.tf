locals {
  s3_origin_id = "${var.name}-site-s3"
  invalidation_param = var.invalidation_paths == [] ? "" : "--paths ${join(" ", var.invalidation_paths)}"
}
