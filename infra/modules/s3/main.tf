resource "aws_s3_bucket" "url_s3" {
  bucket = var.bucket_name

  tags = {
    Name        = "TF State S3 Bucket"
    Environment = var.env
  }
}