
# Bastion Host
Host bastion
  HostName      BASTION_PUBLIC_IP
  User          ubuntu
  IdentityFile  ~/.ssh/your-key.pem

# Private Instance (jump through bastion)
Host private-server
  HostName      PRIVATE_IP         
  User          ubuntu
  IdentityFile  ~/.ssh/your-key.pem
  ProxyJump     bastion