variable "alb_name" {
  type        = string
  description = "ALB Name"
  default = "url-alb"
}

variable "alb_sg" {
  type        = string
  description = "ALB Security Group"
}

variable "public_subnet_1" {
  type        = string
  description = "Public Subnet 1"

}


variable "public_subnet_2" {
  type        = string
  description = "Public Subnet 2"
}

variable "api_port" {
  type        = number
  description = "API Port"
  default = 8080
}

variable "vpc_id" {
  type        = string
  description = "The ID of the newly created VPC"
}

variable "certificate_arn" {
  type        = string
  description = "ACM Certificate ARN"
}

variable "dashboard_port" {
  type        = number
  description = "Dashboard Port"
  default = 8081
}