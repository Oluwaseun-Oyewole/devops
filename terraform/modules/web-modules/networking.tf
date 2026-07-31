data "aws_vpc" "target_vpc" {
  id = "vpc-0d1f582fe8be9b1ab"
}

data "aws_security_group" "existing" {
  filter {
    name   = "group-name"
    values = ["aws-deployments"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.target_vpc.id]
  }
}
