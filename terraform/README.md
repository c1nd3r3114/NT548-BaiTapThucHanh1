# NT548.P11 - Lab 1: Terraform VPC with Public and Private Subnets, Internet Gateway, NAT Gateway, and EC2 Instances

Group members:

|Họ và tên|MSSV|
|---|---|
| Vũ Tuấn Sơn | 21521389 |
| Lê Thanh Lâm | 21521052 |
| Nguyễn Mạnh Hùng | 21520896 |
| Nguyễn Huy Cường | 21520667 |


This Terraform project sets up a Virtual Private Cloud (VPC) with public and private subnets, an Internet Gateway, a NAT Gateway, and EC2 instances. The public EC2 instance is accessible via SSH from a specified IP, and the private EC2 instance can communicate with the public one.

## Prerequisites

- Terraform installed on your local machine
- AWS account with proper access to create VPCs, subnets, gateways, and EC2 instances
- An AWS EC2 key pair (replace `group2-keypair` with your actual key pair)

## AWS Resources Created

- VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables (Public and Private)
- EC2 Instances (Public and Private)
- Security Groups for Public and Private EC2 instances

## Terraform Variables

Before running Terraform, ensure that your AWS credentials are configured either via environment variables or `~/.aws/credentials`. Here's how to set the environment variables:

```bash
export AWS_ACCESS_KEY_ID=your-access-key-id
export AWS_SECRET_ACCESS_KEY=your-secret-access-key
```

## How to use

1. Clone the Repository

```bash
git clone https://github.com/c1nd3r3114/NT548-BaiTapThucHanh1.git
cd NT548-BaiTapThucHanh1/terraform
```

2. Initialize Terraform

Initialize the Terraform workspace before applying the configuration:
```bash
terraform init
```

3. Plan the Terraform Deployment

Run the following command to generate a plan and preview the changes that Terraform will make to your infrastructure:
```bash
terraform plan
```

4. Apply the Terraform Configuration

After reviewing the plan, apply the configuration using the following command:
```bash
terraform apply
```
