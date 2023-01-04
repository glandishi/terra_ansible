
resource "aws_instance" "web_server" {
        ami = "ami-076309742d466ad69"
        instance_type = "t2.micro"
        user_data = file("server_script.sh")
        security_groups = [module.sg.sg_name]
        tags = {
                Name = "web_server"
        }
}
module "sg" {
        source = "../sg"
}
module "eip" {
        source = "../eip"
	instance_id = aws_instance.web_server.id
}
output "pub_ip" {
	value = module.eip.eip_ip
}
