resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.url_shortener.id
  service_name      = "com.amazonaws.eu-west-2.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private_route_table.id
  ]

  tags = {
    Name = "S3 Gateway Endpoint"
  }
}


resource "aws_vpc_endpoint" "secrets_manager" {
  vpc_id            = aws_vpc.url_shortener.id
  service_name      = "com.amazonaws.eu-west-2.secretsmanager"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "Secrets Manager Interface Endpoint"
  }
}

resource "aws_vpc_endpoint" "sqs" {
  vpc_id            = aws_vpc.url_shortener.id
  service_name      = "com.amazonaws.eu-west-2.sqs"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "SQS Interface Endpoint"
  }
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id            = aws_vpc.url_shortener.id
  service_name      = "com.amazonaws.eu-west-2.logs"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "CloudWatch Logs Interface Endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.url_shortener.id
  service_name      = "com.amazonaws.eu-west-2.ecr.api"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "ECR API Interface Endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.url_shortener.id
  service_name      = "com.amazonaws.eu-west-2.ecr.dkr"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "ECR Docker Interface Endpoint"
  }
}



