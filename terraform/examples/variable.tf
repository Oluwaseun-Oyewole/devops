# variables.tf
variable "bucket_name" {
  description = "Globally-unique S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Deployment environment tag"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "az" {
  default = "us-east-1a"
}
