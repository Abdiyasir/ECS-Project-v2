resource "aws_elasticache_serverless_cache" "redis" {
  engine = var.engine_name
  name   = var.redis_name

  major_engine_version = "7"

  cache_usage_limits {
    data_storage {
      maximum = 1
      unit    = "GB"
    }

    ecpu_per_second {
      maximum = 1000
    }
  }

  description = "Serverless Redis cache for URL shortener"

  security_group_ids = [
    var.redis_sg_id
  ]

  subnet_ids = [var.private_subnet_1, var.private_subnet_2]

  snapshot_retention_limit = 1

  tags = {
    Name = "url-shortener-redis"
  }
}