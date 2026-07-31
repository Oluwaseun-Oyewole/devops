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
module "app" {
  source = "../web-modules"

  # Input Variables

  instance_type = "t3.micro"
  instance_name = "terraform_instance"
  bucket_prefix = "terraform"
}

