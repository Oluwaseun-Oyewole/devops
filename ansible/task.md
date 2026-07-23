# Ansible Task: Configure NGINX on a Remote Host

## Objective

Provision two remote Linux servers and use Ansible to configure NGINX on the target server using both:

- Ansible ad-hoc commands
- Ansible playbook automation

## Scope

- Server 1: **Ansible Control Node**
- Server 2: **Managed Node (Target)**
- Configuration target: Install, enable, and verify **NGINX** on the managed node

## Prerequisites

- Two reachable Linux servers (Ubuntu recommended)
- SSH key-based access from control node to managed node
- Python installed on the managed node
- Ansible installed on the control node
- Security group/firewall allows:
  - SSH (`22`) from control node to managed node
  - HTTP (`80`) to access NGINX (as needed)

## Required Implementation

1. Prepare inventory on the control node with the managed host details.
2. Validate connectivity using Ansible ping module.
3. Configure NGINX using ad-hoc commands:
   - Install package
   - Start service
   - Enable service at boot
4. Create and run a playbook that performs the same configuration idempotently.
5. Verify NGINX status and HTTP response from the managed node.

## Expected Deliverables

- Inventory file (for example: `inventory.ini`)
- Playbook file (for example: `nginx-setup.yml`)
- Command execution evidence:
  - Ad-hoc command outputs
  - Playbook run output (`ok/changed/failed` summary)
- Verification evidence (service status and curl/http response)

## Validation Criteria

- Ansible can reach the managed node successfully.
- NGINX is installed and running on the target server.
- NGINX service is enabled on boot.
- Playbook can be re-run without unnecessary changes (idempotent behavior).
- Target server serves default NGINX page on port `80`.

## Suggested Command References

```bash
# Connectivity
ansible all -i inventory.ini -m ping

# Ad-hoc install/start/enable nginx
ansible web -i inventory.ini -b -m apt -a "name=nginx state=present update_cache=yes"
ansible web -i inventory.ini -b -m service -a "name=nginx state=started enabled=yes"

# Playbook execution
ansible-playbook -i inventory.ini nginx-setup.yml
```
