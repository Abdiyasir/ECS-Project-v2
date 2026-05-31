module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_1_cidr = var.public_1_cidr
  public_2_cidr = var.public_2_cidr
  private_1_cidr = var.private_1_cidr
  private_2_cidr = var.private_2_cidr
  igw_cidr = var.igw_cidr
  redis_port = var.redis_port
  rds_port = var.rds_port
  api_port =  var.api_port
  dashboard_port = var.dashboard_port
  az_1 = var.az_1
  az_2 = var.az_2
}



module "sqs" {
  source = "./modules/sqs"
  max_size = var.max_size
  timeout_seconds = var.timeout_seconds
  message_retention = var.message_retention
  wait_time = var.wait_time
}

module "rds" {
  source = "./modules/RDS"
  rds_storage = var.rds_storage
  rds_username = var.rds_username
  db_name = var.db_name
  instance_class = var.instance_class
  db_password = module.secrets-manager.db_password
}

module "secrets_manager" {
  source = "./modules/secrets-manager"
  rds_username = var.rds_username
  db_name = var.db_name
  rds_address = module.RDS.rds_address
  rds_port    = module.RDS.rds_port
  
}

module "IAM" {
  source = "./modules/IAM"
  secret_arn = module.secrets_manager.secret_arn
  sqs_queue_arn = module.sqs.sqs_queue_arn
}

module "redis" {
  source = "./modules/redis"
  engine_name = var.engine_name
  redis_name = var.redis_name
  redis_sg_id = module.vpc.redis_sg
  private_subnet_1 = module.vpc.private_subnet_1
  private_subnet_2 = module.vpc.private_subnet_2
}

module "Cloudwatch" {
  source = "./modules/cloudwatch"
  retention_days = var.retention_days
  log_group_name = var.log_group_name
}