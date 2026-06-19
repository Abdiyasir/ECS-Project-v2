resource "aws_security_group" "api_sg" {
  name   = "api-sg"
  vpc_id = aws_vpc.url_shortener.id
}

resource "aws_security_group_rule" "api_from_alb" {
  type                     = "ingress"
  from_port                = var.api_port
  to_port                  = var.api_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.api_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}



resource "aws_security_group_rule" "api_to_redis" {
  type                     = "egress"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.api_sg.id
  source_security_group_id = aws_security_group.redis_sg.id
}


resource "aws_security_group_rule" "api_to_rds" {
  type                     = "egress"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.api_sg.id
  source_security_group_id = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "api_to_endpoint" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.api_sg.id
  source_security_group_id = aws_security_group.endpoint_sg.id 
}

resource "aws_security_group_rule" "api_to_s3" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.api_sg.id
  prefix_list_ids          = [aws_vpc_endpoint.s3.prefix_list_id]

}

resource "aws_security_group" "worker_sg" {
  name   = "worker-sg"
  vpc_id = aws_vpc.url_shortener.id
}


resource "aws_security_group_rule" "worker_to_endpoint" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_sg.id
  source_security_group_id = aws_security_group.endpoint_sg.id 
}

  resource "aws_security_group_rule" "worker_to_rds" {
  type                     = "egress"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_sg.id
  source_security_group_id = aws_security_group.rds_sg.id 
}

  resource "aws_security_group_rule" "worker_to_s3" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_sg.id
  prefix_list_ids = [aws_vpc_endpoint.s3.prefix_list_id]
}




resource "aws_security_group" "dashboard_sg" {
  name   = "dashboard-sg"
  vpc_id = aws_vpc.url_shortener.id
}

resource "aws_security_group_rule" "dashboard_from_alb" {
  type                     = "ingress"
  from_port                = var.dashboard_port
  to_port                  = var.dashboard_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.dashboard_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "dashboard_to_rds" {
  type                     = "egress"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.dashboard_sg.id
  source_security_group_id = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "dashboard_to_endpoint" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.dashboard_sg.id
  source_security_group_id = aws_security_group.endpoint_sg.id
}
 
resource "aws_security_group_rule" "dashboard_to_s3" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.dashboard_sg.id
  prefix_list_ids = [aws_vpc_endpoint.s3.prefix_list_id]
}
  


resource "aws_security_group" "endpoint_sg" {
  name   = "endpoint-sg"
  vpc_id = aws_vpc.url_shortener.id
}

resource "aws_security_group_rule" "endpoint_from_api" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.endpoint_sg.id
  source_security_group_id = aws_security_group.api_sg.id
}

resource "aws_security_group_rule" "endpoint_from_worker" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.endpoint_sg.id
  source_security_group_id = aws_security_group.worker_sg.id
}

resource "aws_security_group_rule" "endpoint_from_dashboard" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.endpoint_sg.id
  source_security_group_id = aws_security_group.dashboard_sg.id
}
  
resource "aws_security_group_rule" "endpoint_to_all" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.endpoint_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}



resource "aws_security_group" "redis_sg" {
  name   = "redis-sg"
  vpc_id = aws_vpc.url_shortener.id
}


resource "aws_security_group_rule" "redis_from_api" {
  type                     = "ingress"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redis_sg.id
  source_security_group_id = aws_security_group.api_sg.id
}
  


resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.url_shortener.id
}

resource "aws_security_group_rule" "rds_from_api" {
  type                     = "ingress"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.api_sg.id
}


resource "aws_security_group_rule" "rds_from_worker" {
  type                     = "ingress"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.worker_sg.id
}

resource "aws_security_group_rule" "rds_from_dashboard" {
  type                     = "ingress"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.dashboard_sg.id
}



resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.url_shortener.id
}

resource "aws_security_group_rule" "alb_from_https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_from_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_to_api" {
  type                     = "egress"
  from_port                = var.api_port
  to_port                  = var.api_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  source_security_group_id = aws_security_group.api_sg.id
}
  
resource "aws_security_group_rule" "alb_to_dashboard" {
  type                     = "egress"
  from_port                = var.dashboard_port
  to_port                  = var.dashboard_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  source_security_group_id = aws_security_group.dashboard_sg.id
}
