provider "aws" {
  region = "eu-central-1"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "MyVPC"
  }
}
resource "aws_subnet" "mysub_public1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "mysub-public1"
  }
}



resource "aws_security_group" "mysg" {
  vpc_id      = aws_vpc.myvpc.id
  name        = "allow-ssh"
  description = "security group that allows ssh connection"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["165.232.68.132/32", "37.8.230.60/32"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "mygw-public"
  }
}

resource "aws_route_table" "route_public" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }
  tags = {
    Name = "route-public"
  }
}
resource "aws_route_table_association" "route-pub1-assoc" {
  subnet_id      = aws_subnet.mysub_public1.id
  route_table_id = aws_route_table.route_public.id
}

resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = file("~/.ssh/terraform_key.pub")
}

resource "aws_instance" "ansible_aws" {
  ami                    = "ami-076309742d466ad69"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.mysub_public1.id
  count                  = 2
  tags = {
    Name = "ansible_aws_${count.index}"
  }

}

output "aws_public_ip" {
  value = aws_instance.ansible_aws.*.public_ip
}
