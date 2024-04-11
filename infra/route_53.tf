resource "aws_route53_zone" "fe-hosted-zone" {
  name          = "nguyentuannam-cv.online"
  force_destroy = true
}