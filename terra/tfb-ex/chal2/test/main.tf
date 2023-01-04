provider "aws" {
	region = "eu-central-1"
}

resource "aws_instance" "db_server" {
	ami = "ami-076309742d466ad69"
	instance_type = "t2.micro"
	security_groups = [aws_security_group.sec_grp.name]
	tags = {
		Name = "db_server"
	}
}

resource "aws_instance" "web_server" {
	ami = "ami-076309742d466ad69"
        instance_type = "t2.micro"
	user_data = file("server_script.sh")
        security_groups = [aws_security_group.sec_grp.name]
        tags = {
                Name = "web_server"
        }
	
}

resource "aws_eip" "elasticip" {
	instance = aws_instance.web_server.id
}
variable "ingressrule" {
	type = list(number)
	default = [22,80,443]
}
variable "egressrule" {
	type = list(number)
        default = [22,80,443]
}

output "private_ip" {
	value = aws_instance.db_server.private_ip
}

output "public_ip" {
        value = aws_eip.elasticip.public_ip
}


resource "aws_security_group" "sec_grp" {
	name = "Allow 80,443" 
	dynamic "ingress" {
		iterator = port
		for_each = var.ingressrule
		content {
		from_port = port.value
		to_port = port.value
		protocol = "TCP"
		cidr_blocks = ["0.0.0.0/0","165.232.68.132/32"]
		}
	}
	dynamic "egress" {
                iterator = port
                for_each = var.egressrule
                content {
                from_port = port.value
                to_port = port.value
                protocol = "TCP"
                cidr_blocks = ["0.0.0.0/0","165.232.68.132/32"]
                }
        }
}
