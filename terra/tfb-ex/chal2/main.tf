provider "aws" {
	region = "eu-central-1"
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "chal2"
  public_key = file("chal2.pub")
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
        security_groups = [aws_security_group.sec_grp.name]
	key_name = aws_key_pair.my_key_pair.key_name
        tags = {
                Name = "web_server"
        }
	
	connection {
		type = "ssh"
		host = self.public_ip
		user = "ec2-user"
		private_key = file("chal2")
		timeout = "10m"
	}
	provisioner "file" {
		source = "server_script.sh"
		destination = "/tmp/server_script.sh"
	}

	provisioner "remote-exec" {
        	inline = [ 
			"chmod +x /tmp/server_script.sh",
			"sudo /tmp/server_script.sh"
		]
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

output "priv_ip" {
	value = aws_instance.db_server.private_ip
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
