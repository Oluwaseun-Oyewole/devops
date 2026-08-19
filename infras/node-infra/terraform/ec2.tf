
resource "aws_instance" "jenkins" {

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[var.availability_zones[0]].id
  vpc_security_group_ids      = [aws_security_group.web.id, aws_security_group.jenkins.id]
  associate_public_ip_address = var.enable_public_ip_address
  key_name                    = aws_key_pair.jenkins.key_name
  user_data                   = file("./scripts/jenkins-installer.sh")

  tags = {
    Name = "${var.project_name}-jenkins-instance"
  }
}
resource "aws_key_pair" "jenkins" {
  key_name   = var.key_name
  public_key = file(var.ssh_public_key)
}
