# AWS Infrastructure Provisioning with Terraform

This repository contains Terraform code to provision essential AWS services. It is designed to help set up a basic cloud environment for development or testing purposes.

## 🚀 Services Provisioned

The Terraform scripts in this project will provision the following AWS resources:

- **VPC** – Custom Virtual Private Cloud
- **Subnets** – Public and/or private subnets
- **Internet Gateway** – For internet access in public subnets
- **Security Groups** – With configurable ingress/egress rules
- **EC2 Instance** – Amazon Linux or any AMI you specify
- **S3 Bucket** – For storage use
- **Lambda Function** – Basic AWS Lambda setup with IAM role

## 📁 Folder Structure

```bash
├── main.tf # Main Terraform configuration
├── variables.tf # Input variables
├── outputs.tf # Outputs from resources
├── ec2.tf # EC2 instance configuration
├── iam.tf # Iam configuration
├── s3.tf # S3 bucket configuration
├── lambda.tf # Lambda function configuration
└── provider.tf # AWS provider configuration
```

## 🛠️ Prerequisites

- [Terraform](https://www.terraform.io/downloads) v1.0 or higher
- AWS CLI configured with appropriate IAM credentials
- An initialized Terraform backend (local or remote)

## ✅ Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/rakesh-rkz/spark-ai-hackathon-terraform.git
   cd spark-ai-hackathon-terraform
   cd aws-network-setup
    ```
2. Initialize Terraform:

   ```bash
    terraform init
   ```
3. Preview the changes:
   
   ```bash
   terraform plan
   ```
4. Validate the script:

    ```bash
    terraform validate
    ```
5. Apply the changes:    
   ```bash
   terraform apply
   ```
6. Destroy the infrastructure (optional):
   ```bash
   terraform destroy

   ```
## 📌 Notes
- Ensure IAM permissions allow full access to the resources being provisioned.

- This setup is intended for learning or basic environments; not production-hardened.

- Lambda function source code and IAM roles may need to be defined or uploaded separately depending on your setup.