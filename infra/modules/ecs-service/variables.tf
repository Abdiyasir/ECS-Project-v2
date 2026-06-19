variable "private_subnet_1" {
  type = string
}

variable "private_subnet_2" {
  type = string
}

variable "api_sg" {
  type = string
  description = "API Security Group"
}

variable "tg_blue" {
  type = string
  description = "Blue Target Group ARN"
}

variable "cluster_id" {
  type = string
  description = "ECS Cluster ID"
}

variable "task_count" {
  type = number
  description = "How many tasks running"
}

variable "api_port" {
  type        = number
  description = "API Port"

}


variable "dashboard_port" {
  type        = number
  description = "Dashboard Port"

}

variable "listener_arn" {
  type = string
  description = "HTTPS ALB Listener ARN"
}

variable "cpu" {
  type = number
  description = "CPU required"
}

variable "memory" {
  type = number
  description = "Memory required"
}

variable "ecs_task_execution_role_arn" {
  type = string
  description = "ECS Task Execution Role ARN"
}

variable "ecs_task_role_arn" {
  type = string 
  description = "ECS Task Role ARN"
  
}


variable "api_uri" {
  type = string
  description = "API ECR Repo URI"
}

variable "base_url" {
  type = string
  description = "URL being used as a base for the shortener"
}

variable "redis_url" {
  type = string
  description = "Elasticache redis url"
}

variable "ecs_log_group" {
  type = string
  description = "ECS Log Group"
}

variable "aws_region" {
  type = string
  description = "AWS Region"
}

variable "worker_sg" {
  type = string
  description = "Worker Security Group"
}

variable "worker_uri" {
  type = string
  description = "Worker ECR Repo URI"
}

variable "sqs_queue_url" {
  type = string     
  description = "URL for SQS Service"
}

variable "database_secret_arn" {
  type = string
  default = "Secret for Database URL"
}

variable "dashboard_sg" {
  type = string
  description = "Dashboard Security Group"
}

variable "dashboard_uri" {
  type = string
  description = "Dashboard ECR Repo URI"
}

variable "dashboard_tg" {
  type = string
  description = "Dashboard Target Group"
}
