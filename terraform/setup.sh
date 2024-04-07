#!/bin/bash
# Install EPEL release for additional packages
sudo amazon-linux-extras install epel -y
# Update your system
sudo yum update -y
# Install Ansible and Git
sudo yum install ansible git -y
# Clone your repository
git clone https://github.com/odinson-dev/devops_learning.git
# Navigate to the ansible directory
cd devops_learning/ansible
# Run your playbook
ansible-playbook playbook.yml
