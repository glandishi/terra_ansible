#Security Group for levelupvpc
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
    from_port   = 22
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["165.232.68.132/32","37.8.230.60/32"]
  }
  
  tags = {
    Name = "allow-ssh"
  }
}


