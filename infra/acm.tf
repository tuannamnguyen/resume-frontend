resource "aws_acm_certificate" "fe-bucket-certificate" {
  provider = aws.us-east-1

  domain_name       = local.domain_name
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "fe-cert-valdation" {
  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.fe-bucket-certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.records-for-acm : record.fqdn]
}