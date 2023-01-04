provider "aws" {
	region = "eu-central-1"
}

module "web" {
	source = "./web"
}
module "db" {
	source = "./db"
}
output "PrivateIP" {
	value = module.db.db_priv
}
output "PublicIP" {
        value = module.web.pub_ip
}
