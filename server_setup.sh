#!/bin/bash

#If you don't have a key, make one
if [ ! -f "/root/Project_part_2/my_key" ]; then
	ssh-keygen -t rsa -b 4096 -f "my_key" -N ""
fi

#Set up and deploy the instance
cd terraform
terraform init
terraform apply -auto-approve

#Use -raw to get just the ip
#https://stackoverflow.com/questions/66935287/how-to-remove-terraform-double-quotes
ip=$(terraform output -raw instance_public_ip)

#Create inventory for host, then use it with the playbook to install and run minecraft
cd ../ansible

#https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html
echo "[minecraft]" > inventory
echo "${ip} ansible_ssh_user=ec2-user ansible_ssh_private_key_file=$(pwd)/../my_key" >> inventory
ansible-playbook -i inventory playbook.yml
