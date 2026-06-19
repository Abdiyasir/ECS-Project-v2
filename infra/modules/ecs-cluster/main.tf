resource "aws_ecs_cluster" "url_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "provider" {
  cluster_name = aws_ecs_cluster.url_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 0
    capacity_provider = "FARGATE"
  }
}