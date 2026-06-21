module "ecr" {
  source               = "../modules/ecr"
  api_repo             = var.api_repo
  worker_repo          = var.worker_repo
  dashboard_repo       = var.dashboard_repo
  image_tag_mutability = var.image_tag_mutability
}

module "s3" {
  source      = "../modules/s3"
  env         = var.env
  bucket_name = var.bucket_name

}

module "oidc" {
  source = "../modules/oidc"
}