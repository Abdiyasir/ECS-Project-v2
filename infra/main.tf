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
  source = "./modules/rds"
  rds_storage = var.rds_storage
  rds_username = var.rds_username
  db_name = var.db_name
  instance_class = var.instance_class
  db_password = module.secrets_manager.db_password
  private_subnet_1 = module.vpc.private_subnet_1
  private_subnet_2 = module.vpc.private_subnet_2
  rds_sg = module.vpc.rds_sg
}

module "secrets_manager" {
  source = "./modules/secrets-manager"
  rds_username = var.rds_username
  db_name = var.db_name
  rds_address = module.rds.rds_address
  rds_port    = var.rds_port
  
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

module "cloudwatch" {
  source = "./modules/cloudwatch"
  retention_days = var.retention_days
}

module "acm" {
  source = "./modules/acm"
  dns_name = var.dns_name
  zone_id = module.route53.zone_id
}

module "route53" {
  source = "./modules/route53"
  alb_dns_name = module.alb.alb_dns_name
  dns_name = var.dns_name 
  alb_zone_id = module.alb.alb_zone_id
}

module "alb" {
  source = "./modules/alb"
  certificate_arn = module.acm.certificate_arn
  alb_name = var.alb_name
  api_port = var.api_port 
  vpc_id = module.vpc.vpc_id
  public_subnet_1 = module.vpc.public_subnet_1
  public_subnet_2 = module.vpc.private_subnet_2
  alb_sg = module.vpc.alb_sg
  dashboard_port = var.dashboard_port
}

module "waf" {
  source = "./modules/waf"
  waf_log_group_arn = module.cloudwatch.waf_log_group
  alb_arn = module.alb.alb_arn
}

module "ecs-cluster" {
  source = "./modules/ecs-cluster"
  cluster_name = var.cluster_name
}

module "ecs-service" {
  source = "./modules/ecs-service"
  dashboard_port = var.dashboard_port
  cluster_id = module.ecs-cluster.cluster_id
  listener_arn = module.alb.listener_arn
  ecs_task_role_arn = module.IAM.ecs_task_role_arn
  ecs_task_execution_role_arn = module.IAM.ecs_task_execution_role_arn
  memory = var.memory
  ecs_log_group = module.cloudwatch.ecs_log_group
  worker_sg = module.vpc.worker_sg
  task_count = var.task_count
  api_sg = module.vpc.api_sg
  aws_region = var.aws_region
  cpu = var.cpu
  api_port = var.api_port
  worker_uri = var.worker_uri
  dashboard_tg = module.alb.dashboard_tg
  dashboard_sg = module.vpc.dashboard_sg
  api_uri = var.api_uri
  tg_blue = module.alb.tg_blue
  dashboard_uri = var.dashboard_uri
  private_subnet_1 = module.vpc.private_subnet_1
  private_subnet_2 = module.vpc.private_subnet_2
  base_url = var.base_url
  redis_url = "rediss://${module.redis.redis_endpoint}:6379"
  sqs_queue_url = module.sqs.sqs_queue_url
  database_secret_arn = module.secrets_manager.secret_arn
}


module "code-deploy" {
  source = "./modules/code-deploy"
  https_listener_arn = module.alb.listener_arn
  tg_blue_name = module.alb.tg_blue_name
  tg_green_name = module.alb.tg_green_name
  cluster_name = var.cluster_name
  codedeploy_role_arn = module.IAM.codedeploy_role_arn

  depends_on = [
    module.ecs-service
  ]

}