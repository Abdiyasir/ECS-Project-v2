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

variable "db_password" {
  type      = string
  sensitive = true
}