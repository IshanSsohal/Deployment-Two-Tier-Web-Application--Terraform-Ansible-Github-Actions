# AWS Terraform Ansible Project

## Overview

This project automates the provisioning of a two-tier web application infrastructure on AWS using Terraform and Ansible. It sets up environments (Development, Staging, Production) with a consistent AWS architecture, manages configurations with Ansible, and uses Git branching strategies to segregate environments. The end result is a fully configured VPC with webservers accessible via SSH and HTTP, and private resources accessible through a bastion host and NAT gateway.

---

## AWS Architecture

**Key Components:**
- **VPC:** A Virtual Private Cloud is created to host all resources.
- **Public Subnets:** Four public subnets span across different Availability Zones. These subnets host EC2 instances running HTTP webservers. SSH and HTTP access are available.
- **Private Subnets:** Two private subnets are created for instances that are not directly reachable from the internet.
- **Bastion Host:** A bastion host in one of the public subnets provides SSH access to private resources.
- **NAT Gateway:** A NAT Gateway resides in the first public subnet, allowing outbound internet access for instances in the private subnets.
- **S3 Bucket:** S3 buckets are used to store images and as Terraform backend storage (based on environment: dev, staging, prod).

---

## Tools and Technologies

- **Terraform:** Used for infrastructure provisioning.
- **Ansible:** Used for configuration management (installing webservers, testing connectivity).
- **Git & GitHub:** Version control and branch management.
- **Dynamic Inventory with Ansible:** Ansible dynamically pulls inventory data from AWS to manage configurations and deployments.

---

## Branching Strategy

- **Environments:** 
  - `dev` branch for Development
  - `staging` branch for Staging
  - `prod` branch for Production

Each branch corresponds to a separate environment. Before deploying a new environment, it is recommended to destroy the previous one, as the sandbox environment may not support multiple simultaneous infrastructures.

---

## Prerequisites


1. **S3 Buckets for Environments:**  
   - Create S3 buckets for each environment. For example:
     - `group-7-dev`
     - `group-7-staging`
     - `group-7-prod`
   
   Upload the webserver image to the appropriate environment bucket and generate a pre-signed URL.

2. **Git Repository:**  
   Clone the `ACS730FinalProjectGroup7` repository and checkout the branch corresponding to the environment you want to deploy:
   ```bash
   git clone https://github.com/YourOrg/ACS730FinalProjectGroup7.git
   cd ACS730FinalProjectGroup7
   git checkout dev    # or staging or prod



