variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-04585b9248d9f1950"
}

variable "cidr" {
  description = "CIDR block for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-02ebdb11bae1b2486"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
  default     = "subnet-0d192c5b1cf9e1bfa"
}

variable "ssh_public_key" {
  description = "ssh public key"
  type        = string
  default     = "/var/lib/jenkins/.ssh/id_ed25519.pub"
}

variable "ssh_private_key" {
  description = "ssh private key"
  type        = string
  default     = "/var/lib/jenkins/.ssh/id_ed25519"
}