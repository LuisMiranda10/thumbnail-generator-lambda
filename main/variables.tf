variable "aws_region" {
  type        = string
  description = "AWS region to use for resources"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
}

variable "source_bucket_prefix" {
  type        = string
  description = "A prefix applied to the source S3 bucket created to ensure a unique name."
  default     = "source-bucket"
}

variable "dest_bucket_prefix" {
  type        = string
  description = "A prefix applied to the destination S3 bucket created to ensure a unique name."
  default     = "destination-bucket"
}

variable "service_name" {
  type        = string
  description = "Service name used in tags"
  default     = "project-thumbnail"
}