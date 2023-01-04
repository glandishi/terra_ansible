provider "aws" {
    region = "eu-central-1"
}
resource "aws_instance" "db" {
    ami = "ami-076309742d466ad69"
    instance_type = "t2.micro"
    tags = {
	Name = "DB Server"
    }

}
resource "aws_instance" "web" {
    ami = "ami-076309742d466ad69"
    instance_type = "t2.micro"
    depends_on = [aws_instance.db]
    tags = {
        Name = "WEB Server"
    }


}

data "aws_instance" "dbsearch" {
        filter {
                name = "tag:Name"
                values = ["DB Server"]
        }
}
output "dbservers" {
        value = data.aws_instance.dbsearch.availability_zone
}

