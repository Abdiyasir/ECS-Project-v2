variable "codedeploy_role_arn" {
  type = string
  description = "Code Deploy IAM Role ARN"
}

variable "cluster_name" {
  type = string
  description = "ECS Cluster Name"
}

variable "https_listener_arn" {
  type = string
  description = "Listener on HTTPS"
}

variable "tg_blue_name" {
  type = string
  description = "Blue Target Group Name"
}

variable "tg_green_name" {
  type = string
  description = "Green Target Group Name"
}