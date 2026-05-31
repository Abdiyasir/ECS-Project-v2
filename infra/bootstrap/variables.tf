variable "image_tag_mutability" {
    type = string
    description = "ECR Image Tag Mutability"
  
}

variable "api_repo" {
    type = string
    description = "API ECR Repo Name"
  
}

variable "worker_repo" {
    type = string
    description = "Worker ECR Repo Name"
  
}

variable "dashboard_repo" {
    type = string
    description = "Dashboard ECR Repo Name"
  
}