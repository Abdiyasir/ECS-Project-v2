output "ecs_task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ECS Task Role ARN"
  value = aws_iam_role.ecs_task_role.arn
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy_role.arn
}