variable "bucket_name" {
  type        = string
  description = "S3 Bucket Name"
  default     = "url-s3-156165"

}

variable "env" {
  type        = string
  description = "S3 Environment"
  default     = "Dev"
}