resource "aws_ecr_repository" "api_repo" {
  name                 = var.api_repo
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "worker_repo" {
  name                 = var.worker_repo
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "dashboard_repo" {
  name                 = var.dashboard_repo
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }
}