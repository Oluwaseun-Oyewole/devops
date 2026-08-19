
# terraform {
# # uncomment and configure a remote backend
#   backend "s3" {
#     bucket         = "${var.project_name}-terraform-state-bucket"
#     key            = "${var.project_name}/vpc/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }