#!/bin/bash

if [ ! -f "/root/Project_part_2/my_key" ]; then
	ssh-keygen -t rsa -b 4096 -f "my_key"
fi

cd terraform
terraform init
terraform apply -auto-approve

ip=$(terraform output -raw instance_public_ip)

cd ../ansible

echo "[minecraft]" > inventory
echo "${ip} ansible_ssh_user=ec2-user ansible_ssh_private_key_file=$(pwd)/../my_key" >> inventory

ansible-playbook -i inventory playbook.yml
