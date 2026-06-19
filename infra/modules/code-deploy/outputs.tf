output "codedeploy_app_name" {
  value = aws_codedeploy_app.blue_green.name
}

output "deployment_group_name" {
  value = aws_codedeploy_deployment_group.group.deployment_group_name
}