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
  type        = string
  description = "RDS Secret Username"
}

variable "engine_name" {
  type        = string
  description = "Engine name"
}

variable "redis_name" {
  type        = string
  description = "Redis name"

}

variable "retention_days" {
  type        = number
  description = "Log retention time in days"

}

variable "bucket_name" {
  type        = string
  description = "S3 Bucket Name"

}

variable "env" {
  type        = string
  description = "Project Environment"
}

variable "image_tag_mutability" {
  type        = string
  description = "ECR Image Tag Mutability"

}

variable "api_repo" {
  type        = string
  description = "API ECR Repo Name"

}

variable "worker_repo" {
  type        = string
  description = "Worker ECR Repo Name"

}

variable "dashboard_repo" {
  type        = string
  description = "Dashboard ECR Repo Name"

}

variable "dns_name" {
  type        = string
  description = "DNS Name"
}

variable "alb_name" {
  type        = string
  description = "ALB Name"
}

variable "cluster_name" {
  type        = string
  description = "ECS Cluster Name"
}

variable "task_count" {
  type        = number
  description = "How many tasks running"
}

variable "cpu" {
  type        = number
  description = "CPU required"
}

variable "memory" {
  type        = number
  description = "Memory required"
}

variable "base_url" {
  type        = string
  description = "URL being used as a base for the shortener"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "api_uri" {
  type        = string
  description = "API ECR Repo URI"
}

variable "worker_uri" {
  type        = string
  description = "Worker ECR Repo URI"
}

variable "dashboard_uri" {
  type        = string
  description = "Dashboard ECR Repo URI"
}