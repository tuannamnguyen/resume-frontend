output "route53_zone_nameservers" {
  description = "Name servers of Route 53 zone"
  value = aws_route53_zone.fe-hosted-zone.name_servers
}