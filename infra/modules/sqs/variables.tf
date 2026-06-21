variable "timeout_seconds" {
  type        = number
  description = "Message visibility time"
  default     = 30
}

variable "message_retention" {
  type        = number
  description = "Message retention time"
  default     = 86400
}

variable "wait_time" {
  type        = number
  description = "Message wait time"
  default     = 10
}

variable "max_size" {
  type        = number
  description = "Max message size"
  default     = 262144
}