resource "aws_security_group" "api_sg" {
  name   = "api-sg"
  vpc_id = aws_vpc.url_shortener.id

  ingress {
    from_port       = var.api_port
    to_port         = var.api_port
    protocol        = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  egress {
    from_port       = var.redis_port
    to_port         = var.redis_port
    protocol        = "tcp"

    security_groups = [
      aws_security_group.redis_sg.id
    ]
  }

  egress {
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"

    security_groups = [
      aws_security_group.rds_sg.id
    ]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"

    security_groups = [
      aws_security_group.endpoint_sg.id
    ]
  }

  egress {
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  prefix_list_ids = [aws_vpc_endpoint.s3.prefix_list_id]
}

  tags = {
    Name = "API Security Group"
  }
}


resource "aws_security_group" "worker_sg" {
  name   = "worker-sg"
  vpc_id = aws_vpc.url_shortener.id

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.endpoint_sg.id]
  }

  egress {
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups = [aws_security_group.rds_sg.id]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = [aws_vpc_endpoint.s3.prefix_list_id]
  }

  tags = {
    Name = "Worker Security Group"
  }
}

resource "aws_security_group" "dashboard_sg" {
  name   = "dashboard-sg"
  vpc_id = aws_vpc.url_shortener.id

  ingress {
    from_port       = var.dashboard_port
    to_port         = var.dashboard_port
    protocol        = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  egress {
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups = [aws_security_group.rds_sg.id]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.endpoint_sg.id]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = [aws_vpc_endpoint.s3.prefix_list_id]
  }

  tags = {
    Name = "Dashboard Security Group"
  }
}

resource "aws_security_group" "endpoint_sg" {
  name   = "endpoint-sg"
  vpc_id = aws_vpc.url_shortener.id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    security_groups = [
      aws_security_group.api_sg.id,
      aws_security_group.worker_sg.id,
      aws_security_group.dashboard_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Endpoint Security Group"
  }
}


resource "aws_security_group" "redis_sg" {
  name   = "redis-sg"
  vpc_id = aws_vpc.url_shortener.id

  ingress {
    from_port       = var.redis_port
    to_port         = var.redis_port
    protocol        = "tcp"
    security_groups = [aws_security_group.api_sg.id]
  }

  tags = {
    Name = "Elasticache Redis Security Group"
}
}


resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.url_shortener.id

  ingress {
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"

    security_groups = [
      aws_security_group.worker_sg.id,
      aws_security_group.dashboard_sg.id,
      aws_security_group.api_sg.id
    ]
  }

  tags = {
    Name = "RDS Security Group"
}
}

resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.url_shortener.id

  ingress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
  
  egress {
    from_port       = var.api_port
    to_port         = var.api_port
    protocol        = "tcp"
    security_groups = [aws_security_group.api_sg.id]
  }

  egress {
    from_port       = var.dashboard_port
    to_port         = var.dashboard_port
    protocol        = "tcp"
    security_groups = [aws_security_group.dashboard_sg.id]
  }

  tags = {
    Name = "Application Load Balancer Security Group"
}
}