resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "ECS_Logs"
  retention_in_days = var.retention_days
}


resource "aws_cloudwatch_log_group" "waf_log_group" {
  name              = "aws-waf-logs-url"
  retention_in_days = var.retention_days
}

