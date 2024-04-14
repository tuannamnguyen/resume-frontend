locals {
  domain_name = "nguyentuannam-cv.online"
}

resource "aws_route53_zone" "fe-hosted-zone" {
  name          = local.domain_name
  force_destroy = true
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


resource "aws_route53_record" "record-route-to-cloudfront" {
  zone_id = aws_route53_zone.fe-hosted-zone.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    zone_id                = aws_cloudfront_distribution.fe-cloudfront-distribution.hosted_zone_id
    name                   = aws_cloudfront_distribution.fe-cloudfront-distribution.domain_name
    evaluate_target_health = "false"
  }
}
