variable "image_tag_mutability" {
  type        = string
  description = "ECR Image Tag Mutability"
  default = "IMMUTABLE"

}

variable "api_repo" {
  type        = string
  description = "API ECR Repo Name"
  default = "api_ecr"

}

variable "worker_repo" {
  type        = string
  description = "Worker ECR Repo Name"
  default = "worker_ecr"
}

variable "dashboard_repo" {
  type        = string
  description = "Dashboard ECR Repo Name"
  default = "dashboard_ecr"

}