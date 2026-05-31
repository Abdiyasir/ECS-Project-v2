output "api_ecr_name" {
  description = "Name of API ECR repo"
  value       = aws_ecr_repository.api_repo
}

output "worker_ecr_name" {
  description = "Name of Worker ECR repo"
  value       = aws_ecr_repository.worker_repo
}

output "dashboard_ecr_name" {
  description = "Name of Dashboard ECR repo"
  value       = aws_ecr_repository.dashboard_repo
}

output "api_ecr_repo_uri" {
  description = "Repo URI"
  value       = aws_ecr_repository.api_repo.repository_url
}

output "worker_ecr_repo_uri" {
  description = "Repo URI"
  value       = aws_ecr_repository.worker_repo.repository_url
}

output "dashboard_ecr_repo_uri" {
  description = "Repo URI"
  value       = aws_ecr_repository.dashboard_repo.repository_url
}