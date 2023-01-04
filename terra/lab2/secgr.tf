data "aws_ip_ranges" "us_east_ip_range" {
	regions = ["us-east-1"]
	services = ["ec2"]
}

resource "aws_security_group" "custom_us_east" {
	name = "custom_us_east"

	ingress {
		from_port = "443"
		to_port = "443"
		protocol = "TCP"
		cidr_blocks = ["37.8.230.60/32"]
	}
	tags = {
		CreateDate = data.aws_ip_ranges.us_east_ip_range.create_date
		SyncToken = data.aws_ip_ranges.us_east_ip_range.sync_token
	}
}

