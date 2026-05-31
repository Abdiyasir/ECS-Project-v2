variable "redis_sg_id" {
  type        = number
  description = "Redis Security Group ID"

}

variable "private_subnet_1" {
  type        = number
  description = "Private Subnet 1"

}


variable "private_subnet_2" {
  type        = number
  description = "Private Subnet 2"

}

variable "engine_name" {
  type        = string
  description = "Engine Name"

}

variable "redis_name" {
  type        = string
  description = "Redis name"

}