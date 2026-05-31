variable "rds_username" {
  type = string
  description= "RDS Secret Username" 
}

variable "db_name" {
  type        = string
  description = "RDS Database Name"

}

variable "rds_address" {
  type = string
}

variable "rds_port" {
  type = number
}