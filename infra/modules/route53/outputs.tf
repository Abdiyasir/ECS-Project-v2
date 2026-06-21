output "dns_name" {
  description = "DNS Name"
  value       = var.dns_name
}

output "zone_id" {
  description = "DNS Name"
  value       = data.aws_route53_zone.hosted_zone.zone_id
}


