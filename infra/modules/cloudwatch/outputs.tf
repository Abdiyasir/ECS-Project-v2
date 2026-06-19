output "waf_log_group" {
  value = aws_cloudwatch_log_group.waf_log_group.arn
}

output "ecs_log_group" {
  value = aws_cloudwatch_log_group.ecs_log_group.name
}
