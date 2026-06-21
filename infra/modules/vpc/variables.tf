variable "api_port" {
  type        = number
  description = "API Port"
  default = 8080
}

variable "redis_port" {
  type        = number
  description = "Elasticache Redis Port"
  default = 6379

}

variable "rds_port" {
  type        = number
  description = "RDS Port"
  default = 5432

}

variable "dashboard_port" {
  type        = number
  description = "Dashboard Port"
  default = 8081

}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
  default = "0.0.0.0/16"

}

variable "public_1_cidr" {
  type        = string
  description = "Public Subnet 1 CIDR Block"
  default = "10.0.1.0/24"

}

variable "public_2_cidr" {
  type        = string
  description = "Public Subnet 2 CIDR Block"
  default = "10.0.2.0/24"

}

variable "private_1_cidr" {
  type        = string
  description = "Private Subnet 1 CIDR Block"
  default = "10.0.3.0/24"

}

variable "private_2_cidr" {
  type        = string
  description = "Private Subnet 2 CIDR Block"
  default = "10.0.4.0/24"

}

variable "igw_cidr" {
  type        = string
  description = "Internet Gateway CIDR Block"
  default = "0.0.0.0/0"

}

variable "az_1" {
  type        = string
  description = "Availability Zone 1"
  default = "eu-west-2a"

}

variable "az_2" {
  type        = string
  description = "Availability Zone 2"
  default = "eu-west-2c"
}