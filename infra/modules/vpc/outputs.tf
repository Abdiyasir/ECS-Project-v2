output "vpc_id" {
  description = "The ID of the newly created VPC"
  value       = aws_vpc.url_shortener.id
}

output "public_subnet_1" {
  description = "Public Subnet 1"
  value = aws_subnet.public_1.id
}

output "public_subnet_2" {
  description = "Public Subnet 2"
  value = aws_subnet.public_2.id
}

output "private_subnet_1" {
  description = "Private Subnet 1"
  value = aws_subnet.private_1.id
}

output "private_subnet_2" {
  description = "Private Subnet 2"
  value = aws_subnet.private_2.id
}

output "rds_sg" {
  description = "Private Subnet 2"
  value = aws_security_group.rds_sg.id
}

output "redis_sg" {
  description = "Redis Security Group ID"
  value = aws_security_group.redis_sg.id
}

output "alb_sg" {
  description = "ALB Security Group"
  value = aws_security_group.alb_sg.id
}

output "api_sg" {
  description = "API Security Group"
  value = aws_security_group.api_sg.id
}

output "worker_sg" {
  description = "Worker Security Group"
  value = aws_security_group.worker_sg.id
}

output "dashboard_sg" {
  description = "Worker Security Group"
  value = aws_security_group.dashboard_sg.id
}