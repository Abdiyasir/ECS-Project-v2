resource "aws_lb" "url_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  subnets            = [var.public_subnet_1, var.public_subnet_2]

  enable_deletion_protection = true

  tags = {
    Environment = "dev"
  }
}


resource "aws_lb_target_group" "blue" {
  name        = "tg-blue"
  port        = var.api_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/healthz"
    matcher             = "200"
    interval            = 15
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "green" {
  name        = "tg-green"
  port        = var.api_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/healthz"
    matcher             = "200"
    interval            = 15
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "dashboard" {
  name        = "tg-dashboard"
  port        = var.dashboard_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/healthz"
    matcher             = "200"
    interval            = 15
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.url_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "forward"

    forward {
      target_group {
        arn = aws_lb_target_group.blue.arn
      }
    }
  }

  lifecycle {
    ignore_changes = [
      default_action
    ]
  }
}

resource "aws_lb_listener_rule" "dashboard" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dashboard.arn
  }

  condition {
    path_pattern {
      values = [
        "/summary",
        "/top",
        "/recent",
        "/url/*"
      ]
    }
  }
}
