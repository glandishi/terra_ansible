variable "ingressrule" {
        type = list(number)
        default = [80,443]
}
variable "egressrule" {
        type = list(number)
        default = [80,443]
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
output "sg_name" {
	value = aws_security_group.sec_grp.name
}
