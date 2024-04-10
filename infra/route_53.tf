resource "aws_route53_zone" "fe-hosted-zone" {
  name          = "nguyentuannam-cv.online"
  force_destroy = true
}

resource "aws_route53_record" "fe-record" {
  zone_id = aws_route53_zone.fe-hosted-zone.zone_id
  name    = tolist(aws_acm_certificate.fe-cert.domain_validation_options)[0].resource_record_name
  records = [tolist(aws_acm_certificate.fe-cert.domain_validation_options)[0].resource_record_value]
  type    = tolist(aws_acm_certificate.fe-cert.domain_validation_options)[0].resource_record_type
}
