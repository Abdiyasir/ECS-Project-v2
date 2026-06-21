variable "redis_sg_id" {
  type        = string
  description = "Redis Security Group ID"

}

variable "private_subnet_1" {
  type        = string
  description = "Private Subnet 1"

}


variable "private_subnet_2" {
  type        = string
  description = "Private Subnet 2"

}

variable "engine_name" {
  type        = string
  description = "Engine Name"
  default = "redis"

}

variable "redis_name" {
  type        = string
  description = "Redis name"
  default = "redis"

}