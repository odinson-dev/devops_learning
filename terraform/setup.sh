#!/bin/bash
apt-get update && apt-get install -y ansible
ansible-pull -U <your_ansible_playbook_repository_url> webserver-setup.yml
