[nodes]
%{ for ip in node_ips ~}
${ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/iam-user.pem
%{ endfor ~}
