
resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = file("my_key.pub")
}

resource "aws_instance" "MyFirstInstnace" {
  ami = "ami-076309742d466ad69"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id = aws_subnet.mysub_public3.id

  tags = {
    Name = "custom_instance"
  }

}
