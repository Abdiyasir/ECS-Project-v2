variable "api_port" {
  type        = number
  description = "API Port"
  default     = 8080

}

variable "redis_port" {
  type        = number
  description = "Elasticache Redis Port"
  default     = 6379

}

variable "rds_port" {
  type        = number
  description = "RDS Port"
  default     = 5432

}

variable "dashboard_port" {
  type        = number
  description = "Dashboard Port"
  default     = 8081

}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"

}

variable "public_1_cidr" {
  type        = string
  description = "Public Subnet 1 CIDR Block"
  default     = "10.0.1.0/24"

}

variable "public_2_cidr" {
  type        = string
  description = "Public Subnet 2 CIDR Block"
  default     = "10.0.2.0/24"

}

variable "private_1_cidr" {
  type        = string
  description = "Private Subnet 1 CIDR Block"
  default     = "10.0.3.0/24"

}

variable "private_2_cidr" {
  type        = string
  description = "Private Subnet 2 CIDR Block"
  default     = "10.0.4.0/24"

}

variable "igw_cidr" {
  type        = string
  description = "Internet Gateway CIDR Block"
  default     = "0.0.0.0/0"

}


variable "az_1" {
  type        = string
  description = "Availability Zone 1"
  default     = "eu-west-2a"

}

variable "az_2" {
  type        = string
  description = "Availability Zone 2"
  default     = "eu-west-2c"

}

variable "timeout_seconds" {
  type        = number
  description = "Message visibility time"
  default     = 30
}

variable "message_retention" {
  type        = number
  description = "Message retention time"
  default     = 86400
}

variable "wait_time" {
  type        = number
  description = "Message wait time"
  default     = 10
}

variable "max_size" {
  type        = number
  description = "Max message size"
  default     = 262144
}

variable "rds_storage" {
  type        = number
  description = "RDS allocated storage"
  default     = 20

}

variable "db_name" {
  type        = string
  description = "RDS Database Name"

}

variable "instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t4g.micro"

}

variable "rds_username" {
  type        = string
  description = "RDS Secret Username"
}

variable "engine_name" {
  type        = string
  description = "Engine name"
  default     = "redis"
}

variable "redis_name" {
  type        = string
  description = "Redis name"
  default     = "redis"

}

variable "retention_days" {
  type        = number
  description = "Log retention time in days"
  default     = 30

}

variable "bucket_name" {
  type        = string
  description = "S3 Bucket Name"
  default     = "url-s3-156165"

}

variable "env" {
  type        = string
  description = "Project Environment"
  default     = "Dev"
}

variable "image_tag_mutability" {
  type        = string
  description = "ECR Image Tag Mutability"
  default     = "IMMUTABLE"

}

variable "api_repo" {
  type        = string
  description = "API ECR Repo Name"
  default     = "api_ecr"

}

variable "worker_repo" {
  type        = string
  description = "Worker ECR Repo Name"
  default     = "worker_ecr"

}

variable "dashboard_repo" {
  type        = string
  description = "Dashboard ECR Repo Name"
  default     = "dashboard_ecr"

}

variable "dns_name" {
  type        = string
  description = "DNS Name"
  default     = "abdiyasir-ecsv2.org"
}

variable "alb_name" {
  type        = string
  description = "ALB Name"
  default     = "url-alb"
}

variable "cluster_name" {
  type        = string
  description = "ECS Cluster Name"
  default = "url-cluster"
}

variable "task_count" {
  type        = number
  description = "How many tasks running"
  default = 2
}

variable "cpu" {
  type        = number
  description = "CPU required"
  default = 256
}

variable "memory" {
  type        = number
  description = "Memory required"
  default = 512
}

variable "base_url" {
  type        = string
  description = "URL being used as a base for the shortener"
  default = "https://abdiyasir-ecsv2.org"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default = "eu-west-2"
}

variable "api_uri" {
  type        = string
  description = "API ECR Repo URI"
  default = "306758374042.dkr.ecr.eu-west-2.amazonaws.com/api_ecr:v1"
}

variable "worker_uri" {
  type        = string
  description = "Worker ECR Repo URI"
  default = "306758374042.dkr.ecr.eu-west-2.amazonaws.com/worker_ecr:v1"
}

variable "dashboard_uri" {
  type        = string
  description = "Dashboard ECR Repo URI"
  default = "306758374042.dkr.ecr.eu-west-2.amazonaws.com/dashboard_ecr:v1"
}