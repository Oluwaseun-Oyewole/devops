# Production Architecture (AWS)

## Objective

Design a highly available VPC architecture across **2 Availability Zones (AZs)** with:

- A **Layer 7 Load Balancer** (Application Load Balancer, ALB)
- An **Auto Scaling Group (ASG)** for application instances
- Public and private subnets in each AZ
- One NAT Gateway in each public subnet
- A **Bastion (Jump) Host** for secure SSH access to private instances

## Network Layout

- **VPC** spans 2 AZs (for example: `AZ-a` and `AZ-b`).
- In each AZ:
  - **1 Public Subnet**
  - **1 Private Subnet**
- **Public subnets** host:
  - ALB nodes
  - NAT Gateways
  - Bastion host (single EC2 instance, typically in one public subnet)
- **Private subnets** host:
  - EC2 instances managed by the Auto Scaling Group

## Administrative Access (Bastion / Jump Host)

- Direct SSH access to private instances from the internet is **not allowed**.
- Administrators first SSH into the **Bastion Host** using the `.pem` key.
- From the bastion host, SSH access to private instances is performed using **SSH agent forwarding**.
- Recommended security controls:
  - Allow SSH (`22`) to bastion only from trusted admin IP ranges.
  - Allow SSH (`22`) to private instances only from the bastion security group.
  - Disable public IP assignment on private instances.

## Traffic Flow

1. Internet traffic enters through the **ALB** in public subnets.
2. ALB forwards requests to EC2 instances in **private subnets** across both AZs.
3. Private instances access the internet for outbound traffic (updates, package downloads, external APIs) via **NAT Gateways** in their respective AZ public subnets.
4. Admin access path: **Admin Laptop -> Bastion Host -> Private EC2 (SSH forwarding)**.

## High Availability Notes

- Multi-AZ ALB deployment improves availability.
- ASG distributes instances across both private subnets.
- One NAT Gateway per AZ avoids a single point of failure for outbound traffic.
- Bastion host centralizes and controls privileged SSH access into private subnets.

## Diagram (Mermaid)

```mermaid
flowchart TB
	Internet((Internet)) --> ALB[Application Load Balancer (L7)]
	Admin[Admin Laptop\nPEM Key] -->|SSH :22| Bastion[Bastion / Jump Host\nPublic Subnet]

	subgraph VPC[VPC]
		direction TB

		subgraph AZA[Availability Zone A]
			direction TB
			PubA[Public Subnet A\n- NAT Gateway A\n- ALB Node A]
			PrivA[Private Subnet A\n- EC2 App Instances (ASG)]
			PrivA -->|Outbound| NATa[NAT Gateway A]
			NATa --> IGW[Internet Gateway]
		end

		subgraph AZB[Availability Zone B]
			direction TB
			PubB[Public Subnet B\n- NAT Gateway B\n- ALB Node B]
			PrivB[Private Subnet B\n- EC2 App Instances (ASG)]
			PrivB -->|Outbound| NATb[NAT Gateway B]
			NATb --> IGW
		end

		ALB --> PrivA
		ALB --> PrivB
		Bastion -->|SSH Forwarding :22| PrivA
		Bastion -->|SSH Forwarding :22| PrivB
	end
```

## Summary

This architecture provides a clean, production-ready baseline with multi-AZ resilience, secure private application tiers, controlled administrative access through a bastion host, and scalable traffic handling via ALB + ASG.
