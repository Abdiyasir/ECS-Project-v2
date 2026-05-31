variable "timeout_seconds" {
  type        = number
  description = "Message visibility time"
}

variable "message_retention" {
  type        = number
  description = "Message retention time"
}

variable "wait_time" {
  type        = number
  description = "Message wait time"
}

variable "max_size" {
  type        = number
  description = "Max message size"
}