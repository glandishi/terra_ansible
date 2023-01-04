resource "aws_instance" "FirstTerra" {
	ami = "ami-09042b2f6d07d164a"
	instance_type = "t2.micro"

tags = {
	Name = "andy_machine"
}
}
