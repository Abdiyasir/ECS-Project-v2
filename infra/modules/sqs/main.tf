resource "aws_sqs_queue" "sqs_queue" {
  name = "click-events-queue"

  visibility_timeout_seconds = var.timeout_seconds
  message_retention_seconds  = var.message_retention
  receive_wait_time_seconds  =var.wait_time
  max_message_size = var.max_size

  tags = {
    Name = "Click Events Queue"
  }
}