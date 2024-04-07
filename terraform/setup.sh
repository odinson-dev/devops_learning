#!/bin/bash
apt-get update && apt-get install -y ansible git
git clone https://github.com/odinson-dev/devops_learning.git
cd devops_learning/ansible
ansible-playbook playbook.yml