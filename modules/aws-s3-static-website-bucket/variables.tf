variable "bucket_prefix" {
  description = "Prefix of the s3 bucket. We need to guarantee that bucket name is unique."
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
