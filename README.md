# Terraform101
Terraform Deployment of Python application with Azure Devops Pipeline
# Terraform Configuration and Shell Script Explanation

## Terraform Configuration

### AWS EC2 Instance (`aws_instance`)

- The `aws_instance` resource deploys an EC2 instance.
- It provisions the instance with a file and a remote-exec provisioner.
- The `connection` block specifies SSH connection details.
- Tags the instance with "for pyhton Deployment."

### AWS Security Group (`aws_security_group`)

- The `aws_security_group` resource defines a security group.
- It allows inbound traffic on ports 443, 22, 8000, and 3389 from any source.

## Shell Script (`script.sh`)

- The shell script is executed as user data during EC2 instance provisioning.

### Software Installation

- Installs Chocolatey, Python, and Git using Chocolatey.
- Upgrades `pip` and installs Django.

### Directory Setup and Git

- Creates directories and installs Git.
- Clones a Git repository from Azure DevOps.

### Firewall and Remote Desktop

- Configures firewall rules to allow inbound traffic on port 8000.
- Enables Remote Desktop.

### Django Server

- Runs Django database migrations.
- Starts the Django development server on 0.0.0.0:8000.

This Terraform configuration and shell script automate the setup of an AWS EC2 instance for hosting a Django application.
