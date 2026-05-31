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

variable "rds_storage" {
  type        = number
  description = "RDS allocated storage"

}

variable "db_name" {
  type        = string
  description = "RDS Database Name"

}

variable "instance_class" {
  type        = string
  description = "RDS instance class"

}

variable "rds_username" {
  type = string
  description= "RDS Secret Username" 
}

variable "engine_name" {
  type        = string
  description = "Engine name"
}

variable "redis_name" {
  type        = string
  description = "Redis name"

}

variable "log_group_name" {
  type = string
  description = "Cloudwatch Log Group Name"
  
}

variable "retention_days" {
    type = number
    description = "Log retention time in days"
  
}

