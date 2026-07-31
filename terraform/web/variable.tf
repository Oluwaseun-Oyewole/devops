# General Variables

variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "eu-north-1"
}

# EC2 Variables

variable "ami" {
  description = "Amazon machine image to use for ubuntu ec2 instance"
  type        = string
  default     = "ami-0dfb70db812cb70e2"
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "ec2 instance name"
  type        = string
}

# S3 Variables

variable "bucket_prefix" {
  description = "prefix of s3 bucket for app data"
  type        = string
}

# RDS Variables

variable "db_name" {
  description = "Name of DB"
  type        = string
}

variable "db_user" {
  description = "Username for DB"
  type        = string
}

variable "db_pass" {
  description = "Password for DB"
  type        = string
  sensitive   = true
}
