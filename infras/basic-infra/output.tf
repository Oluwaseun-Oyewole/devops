output "control_public_ip" {
  value = aws_instance.control.public_ip
}

output "node_public_ips" {
  value = aws_instance.node[*].public_ip
}
