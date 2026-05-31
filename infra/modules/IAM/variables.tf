variable "secret_arn" {
  type        = string
  description = "Secrets Manager ARN"
}

variable "sqs_queue_arn" {
  type        = string
  description = "SQS queue ARN"
}
