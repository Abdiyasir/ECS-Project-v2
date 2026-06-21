resource "aws_ecs_service" "api" {
  name            = "api-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.api_task.arn
  desired_count   = var.task_count

  launch_type                       = "FARGATE"
  platform_version                  = "LATEST"
  health_check_grace_period_seconds = 60


  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = [var.private_subnet_1, var.private_subnet_2]
    security_groups  = [var.api_sg]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.tg_blue
    container_name   = "api_container"
    container_port   = var.api_port
  }

  depends_on = [var.listener_arn]

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer,
      platform_version
    ]
  }

}

resource "aws_ecs_task_definition" "api_task" {
  family                   = "api-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "api_container"
      image     = var.api_uri
      essential = true

      portMappings = [
        {
          containerPort = var.api_port
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "SQS_QUEUE_URL"
          value = var.sqs_queue_url
        },
        {
          name  = "REDIS_URL"
          value = var.redis_url
        },
        {
          name  = "BASE_URL"
          value = var.base_url
        },
        {
          name  = "CACHE_TTL_SECONDS"
          value = "300"
        }
      ]

      secrets = [
        {
          name      = "DATABASE_URL"
          valueFrom = var.database_secret_arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_log_group
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "api"
        }
      }
    }
  ])
}


resource "aws_ecs_service" "worker" {
  name            = "worker-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.worker_task.arn
  desired_count   = var.task_count

  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    subnets          = [var.private_subnet_1, var.private_subnet_2]
    security_groups  = [var.worker_sg]
    assign_public_ip = false
  }
}

resource "aws_ecs_task_definition" "worker_task" {
  family                   = "worker-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "worker_container"
      image     = var.worker_uri
      essential = true

      environment = [
        {
          name  = "SQS_QUEUE_URL"
          value = var.sqs_queue_url
        }
      ]

      secrets = [
        {
          name      = "DATABASE_URL"
          valueFrom = var.database_secret_arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_log_group
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "worker"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "dashboard" {
  name            = "dashboard-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.dashboard_task.arn
  desired_count   = var.task_count

  launch_type                       = "FARGATE"
  platform_version                  = "LATEST"
  health_check_grace_period_seconds = 60


  network_configuration {
    subnets          = [var.private_subnet_1, var.private_subnet_2]
    security_groups  = [var.dashboard_sg]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.dashboard_tg
    container_name   = "dashboard_container"
    container_port   = var.dashboard_port
  }

  depends_on = [var.listener_arn]

}

resource "aws_ecs_task_definition" "dashboard_task" {
  family                   = "dashboard-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "dashboard_container"
      image     = var.dashboard_uri
      essential = true

      portMappings = [
        {
          containerPort = var.dashboard_port
          protocol      = "tcp"
        }
      ]

      secrets = [
        {
          name      = "DATABASE_URL"
          valueFrom = var.database_secret_arn
        },

      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_log_group
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "dashboard"
        }
      }
    }
  ])
}
