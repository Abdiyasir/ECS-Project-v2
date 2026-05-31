variable "log_group_name" {
  type = string
  description = "Cloudwatch Log Group Name"
  
}

variable "retention_days" {
    type = number
    description = "Log retention time in days"
  
}