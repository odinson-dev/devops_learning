# DevOps Learning Project

Welcome to the DevOps Learning Project! This guide will walk you through the setup process to get your environment ready for deploying AWS resources using Terraform.

## Prerequisites

Before starting, ensure you have Git and Terraform installed on your machine. Follow the installation guides for your operating system.

### Install Git

- Download and install Git from [Git's official site](https://git-scm.com/downloads).

### Install Terraform

- **Windows**:
  1. Download Terraform from [Terraform's official site](https://www.terraform.io/downloads.html).
  2. Extract the downloaded archive.
  3. Add the extracted directory to your PATH environment variable.

- **Linux**:
  1. Download the Terraform zip file.
     ```
     wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip
     ```
  2. Unzip the file.
     ```
     unzip terraform_0.12.29_linux_amd64.zip
     ```
  3. Move the Terraform executable to a directory included in your PATH.
     ```
     sudo mv terraform /usr/local/bin/
     ```

- **macOS**:
  1. Install Homebrew, then use it to install Terraform.
     ```
     brew install terraform
     ```

## Setup Instructions

1. **Clone the repository**:
```
git clone https://github.com/odinson-dev/devops_learning.git
```

2. **Navigate to the Terraform directory**:
```
cd terraform
```


3. **Generate SSL certificates for `test.example.com`** (replace `test.example.com` with your domain):

```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout test.example.com.key -out test.example.com.crt
```


4. **Initialize Terraform**:
```
terraform init
```


5. **Create a Terraform execution plan**:
```
terraform plan -out infra_plan

```


6. **Apply the Terraform plan** to provision the AWS resources:
```
terraform apply "infra_plan"
```


Congratulations! You've now successfully set up and deployed resources to AWS using Terraform as part of the DevOps Learning Project.

## Additional Resources

For further assistance or to delve deeper into Terraform's capabilities, consider exploring the following resources:

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [AWS Provider Documentation in Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
