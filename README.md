# Project_part_2
[comment]: <> (https://markdown-it.github.io/)
# Requirements:
+ [AWS CLI](https://aws.amazon.com/cli/)
+ [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
+ [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

# How to Start

From the root directory of the project
run: 

     chmod +x sever_setup.sh 
to make it executable

enter your aws credentials in the "credentials" file

run:

    ./server_setup.sh

## What's Happening?
![Diagram](https://github.com/user-attachments/assets/b31bfc2d-34e0-4b89-a7db-14132693c40b)

1. server_setup.sh creates an ssh key if not already made
2. main.tf uses the key to provision infra and output the public ip
3. server_setup.sh uses the public ip to create an inventory file
4. playbook.yml uses the inventory file to make the aws ec2 instance a host
5. playbook.yml installs and starts the minecraft server
