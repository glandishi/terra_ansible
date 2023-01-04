
resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file("my_key.pub")
}

#Create AWS Instance
resource "aws_instance" "MyFirstInstnace" {
  ami           = "ami-076309742d466ad69"
  instance_type = "t2.micro"
  availability_zone = "eu-central-1a"
  key_name      = aws_key_pair.levelup_key.key_name
  vpc_security_group_ids = [aws_security_group.allow-levelup-ssh.id]
  subnet_id = aws_subnet.levelupvpc-public-1.id

  tags = {
    Name = "custom_instance"
  }
}

output "public_ip" {
  value = aws_instance.MyFirstInstnace.public_ip 
}

