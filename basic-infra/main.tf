terraform {
  required_providers {
    aws   = { source = "hashicorp/aws", version = "~> 5.0" }
    local = { source = "hashicorp/local", version = "~> 2.0" }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "ansible_sg" {
  name = "ansible-demo-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # tighten this to your IP in real use
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- Control node ---
resource "aws_instance" "control" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = { Name = "ansible-control" }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  # Install Ansible on the control node once it's up
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install -y ansible",
      "mkdir -p /home/ubuntu/.ansible",
      "echo '[defaults]' > /home/ubuntu/ansible.cfg",
      "echo 'host_key_checking = False' >> /home/ubuntu/ansible.cfg"
    ]
  }

  # Copy the private key so control node can SSH into the nodes
  provisioner "file" {
    source      = var.private_key_path
    destination = "/home/ubuntu/iam-user.pem"
  }

  provisioner "remote-exec" {
    inline = ["chmod 600 /home/ubuntu/iam-user.pem"]
  }
}

# --- Managed nodes ---
resource "aws_instance" "node" {
  count                  = 1
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = { Name = "ansible-node-${count.index + 1}" }
}

# --- Generate Ansible inventory locally, then push it to control node ---
resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"

  content = templatefile("${path.module}/templates/inventory.tpl", {
    node_ips = aws_instance.node[*].public_ip
  })
}

resource "null_resource" "copy_inventory" {
  depends_on = [aws_instance.control, local_file.inventory]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = aws_instance.control.public_ip
  }

  provisioner "file" {
    source      = local_file.inventory.filename
    destination = "/home/ubuntu/inventory.ini"
  }
}

