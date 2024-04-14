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

resource "aws_route53_record" "records-for-acm" {
  for_each = {
    for dvo in aws_acm_certificate.fe-bucket-certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_zone.fe-hosted-zone.zone_id
  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
}

