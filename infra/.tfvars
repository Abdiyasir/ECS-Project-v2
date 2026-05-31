api_port = 8080

redis_port = 6379

rds_port = 5432

dashboard_port = 8081

vpc_cidr = "10.0.0.0/16"

public_1_cidr = "10.0.1.0/24"

public_2_cidr = "10.0.2.0/24"

private_1_cidr = "10.0.3.0/24"

private_2_cidr = "10.0.4.0/24"

igw_cidr = "0.0.0.0/0"

az_1 = "eu-west-2a"

az_2 = "eu-west-2b"

timeout_seconds = 30

message_retention = 86400

wait_time = 10

max_size = 262144

rds_storage = 20

db_name = "urlshortener"

instance_class = "db.t4g.micro"

rds_username = "postgres"

engine_name = "redis"

redis_name = "redis"

log_group_name = "ECS_Logs"

retention_days = 30

image_tag_mutability = "IMMUTABLE"

api_repo = "api_ecr"

worker_repo = "worker_ecr"

dashboard_repo = "dashboard_ecr"