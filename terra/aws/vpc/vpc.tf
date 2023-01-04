provider "aws" {
	region = "eu-central-1"
}

resource "aws_vpc" "myvpc" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = "true"
	enable_dns_hostnames = "true"
	tags = {
		Name = "MyVPC"
	}
}
resource "aws_subnet" "mysub_public1" {
	vpc_id = aws_vpc.myvpc.id
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = "true"
	availability_zone = "eu-central-1a"
	tags = {
		Name = "mysub-public1"
	}
}
resource "aws_subnet" "mysub_public2" {
        vpc_id = aws_vpc.myvpc.id
        cidr_block = "10.0.2.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "eu-central-1b"
        tags = {
                Name = "mysub-public2"
        }
}
resource "aws_subnet" "mysub_public3" {
        vpc_id = aws_vpc.myvpc.id
        cidr_block = "10.0.3.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "eu-central-1c"
        tags = {
                Name = "mysub-public3"
        }
}

resource "aws_subnet" "mysub_priv1" {
        vpc_id = aws_vpc.myvpc.id
        cidr_block = "10.0.4.0/24"
        map_public_ip_on_launch = "false"
        availability_zone = "eu-central-1a"
        tags = {
                Name = "mysub-priv1"
        }
}
resource "aws_subnet" "mysub_priv2" {
        vpc_id = aws_vpc.myvpc.id
        cidr_block = "10.0.5.0/24"
        map_public_ip_on_launch = "false"
        availability_zone = "eu-central-1b"
        tags = {
                Name = "mysub-priv2"
        }
}
resource "aws_subnet" "mysub_priv3" {
        vpc_id = aws_vpc.myvpc.id
        cidr_block = "10.0.6.0/24"
        map_public_ip_on_launch = "false"
        availability_zone = "eu-central-1c"
        tags = {
                Name = "mysub-priv3"
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
	subnet_id = aws_subnet.mysub_public1.id
	route_table_id = aws_route_table.route_public.id
}
resource "aws_route_table_association" "route-pub2-assoc" {
        subnet_id = aws_subnet.mysub_public2.id
        route_table_id = aws_route_table.route_public.id
}
resource "aws_route_table_association" "route-pub3-assoc" {
        subnet_id = aws_subnet.mysub_public3.id
        route_table_id = aws_route_table.route_public.id
}
