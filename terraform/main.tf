provider "aws" {
	region = "us-west-2"
	shared_credentials_files = ["/root/Project_part_2/credentials"]
}

data "aws_vpc" "default" {
	default = true
}

resource "aws_key_pair" "key" {
	key_name = "my_key"
	public_key = file("${path.module}/../my_key.pub")
}

resource "aws_security_group" "minecraft_security" {
	name = "minecraft_security"
	description = "Allow ssh and Minecraft connections"
	vpc_id = data.aws_vpc.default.id

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	ingress {
		from_port = 25565
		to_port = 25565
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_instance" "Minecraft_Server" {
	ami = "ami-0b65bee2e046aec19"
	instance_type = "t4g.small"
	key_name = aws_key_pair.key.key_name
	vpc_security_group_ids = [aws_security_group.minecraft_security.id]

	tags = {
		name = "Minecraft Server"
	}
}

output "instance_public_ip" {
	value = aws_instance.Minecraft_Server.public_ip
}
