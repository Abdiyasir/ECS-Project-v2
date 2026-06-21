variable "rds_storage" {
  type        = number
  description = "RDS allocated storage"
  default = 20

}

variable "db_name" {
  type        = string
  description = "RDS Database Name"

}

variable "instance_class" {
  type        = string
  description = "RDS instance class"
  default = "db.t4g.micro"

}

variable "rds_username" {
  type        = string
  description = "RDS Secret Username"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "private_subnet_1" {
  type = string
}

variable "private_subnet_2" {
  type = string
}

variable "rds_sg" {
  type = string

}