[nodes]
%{ for ip in ips ~}
 ansible_user=ubuntu ansible_ssh_private_key_file=
%{ endfor ~}