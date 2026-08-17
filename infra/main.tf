terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Reads the PUBLIC key you generated with ssh-keygen on this control node
resource "aws_key_pair" "ansible_key" {
  key_name   = "ansible-key"
  public_key = file(var.ssh_public_key)
}

resource "aws_security_group" "ansible_sg" {
  name = "ansible-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }
}

resource "aws_instance" "server-1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ansible_key.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = { Name = "server-1" }

  # just proves the instance is reachable before terraform finishes
  provisioner "remote-exec" {
    inline = ["echo SSH connectivity verified!"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_private_key)
      host        = self.public_ip
    }
  }
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"

  content = templatefile("${path.module}/templates/inventory.tpl", {
    ips              = [aws_instance.server-1.public_ip]
    private_key_path = "/var/lib/jenkins/.ssh/ansible_key"
  })
}

output "server1_public_ip" {
  value = aws_instance.server-1.public_ip
}