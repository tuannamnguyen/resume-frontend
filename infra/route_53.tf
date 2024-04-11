locals {
  domain_name = "nguyentuannam-cv.online"
}

resource "aws_route53_zone" "fe-hosted-zone" {
  name          = local.domain_name
  force_destroy = true
}

resource "aws_route53_record" "fe-route53-record" {
  zone_id = aws_route53_zone.fe-hosted-zone.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    zone_id                = aws_s3_bucket.frontend_bucket.hosted_zone_id
    name                   = aws_s3_bucket_website_configuration.fe_static_site_config.website_domain
    evaluate_target_health = "false"
  }
}