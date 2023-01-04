resource "aws_instance" "db_server" {
        ami = "ami-076309742d466ad69"
        instance_type = "t2.micro"
        tags = {
                Name = "db_server"
        }
}
output "db_priv" {
	value = aws_instance.db_server.private_ip
}
