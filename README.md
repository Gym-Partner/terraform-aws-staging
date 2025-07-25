# Terraform AWS - Gym Partner (Staging)

This repository defines a **staging environment** on AWS using **Terraform**.  
It deploys a secure and minimal infrastructure to host Go-based microservices and a PostgreSQL database.

---

## 📦 Features

- ✅ Custom **VPC** with:
    - 2 Public subnets
    - 2 Private subnets
    - Internet Gateway
    - NAT Gateway (for private subnet internet access)
- 🐧 **EC2** Debian instance (for Go APIs)
- 🐘 **RDS PostgreSQL** in a private subnet
- 🔐 Security Groups for EC2 and RDS
- 🌍 Default tags applied to all resources (e.g. `Environment = "staging"`)

---

## ⚙️ Requirements

- [Terraform](https://developer.hashicorp.com/terraform/downloads) ≥ 1.3
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured (`aws configure`)
- An **RSA EC2 key pair** available in your AWS account
- An IAM user with permissions for EC2, VPC, RDS, and IAM

---

## 🔐 Sensitive Variables

Sensitive variables (such as RDS password and EC2 SSH key name) must be provided via a separate local file:

### 🔑 Example: `terraform.tfvars`
```hcl
key_name       = "your-ec2-key-name"
db_password    = "your-secure-db-password"
aws_access_key = "your-access-key"       # optional if using AWS CLI profile
aws_secret_key = "your-secret-key"       # optional if using AWS CLI profile
```
⚠️ Never commit this file. It should be ignored via .gitignore.

---

## 📂 Project Structure

```
terraform-aws-staging/
├── main.tf               # Entry point – uses VPC, EC2, RDS modules
├── variables.tf          # Global input variables
├── outputs.tf            # Useful Terraform outputs
├── terraform.tfvars      # Secrets (excluded from version control)
├── ec2/                  # EC2 instance configuration
├── rds/                  # RDS PostgreSQL configuration
├── vpc/                  # VPC networking module
```

---

## 🚀 Usage

1. Initialize Terraform

```bash
terraform init
```

2. Validate resources

```bash
terraform validate
```

3. Preview the changes

```bash
terraform plan -var-file="terraform.tfvars"
```

4. Apply the infrastructure

```bash
terraform apply -var-file="terraform.tfvars"
```

5. Destroy the infrastructure

```bash
terraform destroy -var-file="terraform.tfvars"
```