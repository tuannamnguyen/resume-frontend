resource "aws_acm_certificate" "fe-cert" {
  domain_name = "nguyentuannam-cv.online"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "fe-cert-validate" {
  certificate_arn = aws_acm_certificate.fe-cert.arn
  validation_record_fqdns = [aws_route53_record.fe-record.fqdn]
}