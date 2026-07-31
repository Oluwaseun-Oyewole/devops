terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }

  }

}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
resource "aws_instance" "learning" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name        = "terraform-learning"
    Environment = "sandbox"
  }
}

output "instance_id" {
  value = aws_instance.learning.id
}

output "public_ip" {
  value = aws_instance.learning.public_ip
}
