variable "instance_id" {
	type = string
}

resource "aws_eip" "elasticip" {
	instance = var.instance_id
}
output "eip_ip" {
	value = aws_eip.elasticip.public_ip
}
