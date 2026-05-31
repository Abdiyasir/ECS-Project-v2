variable "api_port" {
  type        = number
  description = "API Port"

}

variable "redis_port" {
  type        = number
  description = "Elasticache Redis Port"

}

variable "rds_port" {
  type        = number
  description = "RDS Port"

}

variable "dashboard_port" {
  type        = number
  description = "Dashboard Port"

}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"

}

variable "public_1_cidr" {
  type        = string
  description = "Public Subnet 1 CIDR Block"

}

variable "public_2_cidr" {
  type        = string
  description = "Public Subnet 2 CIDR Block"

}

variable "private_1_cidr" {
  type        = string
  description = "Private Subnet 1 CIDR Block"

}

variable "private_2_cidr" {
  type        = string
  description = "Private Subnet 2 CIDR Block"

}

variable "igw_cidr" {
  type        = string
  description = "Internet Gateway CIDR Block"

}

variable "az_1" {
  type        = string
  description = "Availability Zone 1"

}

variable "az_2" {
  type        = string
  description = "Availability Zone 2"

}