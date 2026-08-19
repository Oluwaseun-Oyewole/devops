output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.node-infra-vpc.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = { for az, subnet in aws_subnet.public : az => subnet.id }
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = { for az, subnet in aws_subnet.private : az => subnet.id }
}

output "web_security_group_id" {
  description = "ID of the web tier security group"
  value       = aws_security_group.web.id
}

output "jenkins_ec2_instance_ip" {
  description = "Public IPs of the EC2 web instances"
  value       = aws_instance.jenkins.public_ip
}