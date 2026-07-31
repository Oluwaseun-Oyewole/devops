terraform {

  #backend "s3" {
  # bucket         = "devops-directive-tf-state"
  # key            = "04-variables-and-outputs/web-app/terraform.tfstate"
  # region         = "eu-north-1"
  # dynamodb_table = "terraform-state-locking"
  # encrypt        = true
  # }


    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.92"
      }
    }

    required_version = ">= 1.2"
  }

provider "aws" {
  region = var.region
}

resource "aws_instance" "instance_1" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.instances.name]
}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_crypto_conf" {
  bucket = aws_s3_bucket.bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_security_group" "instances" {
  name = "instance-security-group"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id

  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
