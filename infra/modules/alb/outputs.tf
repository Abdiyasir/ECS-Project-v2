output "tg_blue" {
  description = "Blue Target Group ARN"
  value = aws_lb_target_group.blue.arn
}

output "tg_green" {
  description = "Green Target Group ARN"
  value = aws_lb_target_group.green.arn
}

output "tg_blue_name" {
  description = "Blue Target Group Name"
  value = aws_lb_target_group.blue.name
}

output "tg_green_name" {
  description = "Green Target Group Name"
  value = aws_lb_target_group.green.name
}

output "alb_dns_name" {
  description = "ALB Public URL"
  value = aws_lb.url_alb.dns_name
}

output "alb_zone_id" {
  value       = aws_lb.url_alb.zone_id
  description = "ALB Hosted Zone."
}

output "alb_arn" {
  description = "ALB ARN"
  value = aws_lb.url_alb.arn
}

output "listener_arn" {
  value = aws_lb_listener.https.arn
}

output "dashboard_tg" {
  description = "Green Target Group ARN"
  value = aws_lb_target_group.dashboard.arn
}