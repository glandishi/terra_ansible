module "gcp" {
  source = "./gcp"
}

module "aws" {
  source = "./aws"
}

resource "local_file" "pub_ips" {
  filename = "hosts"
  content  = "[all]\nec2-user@${module.aws.aws_public_ip[0]}\nec2-user@${module.aws.aws_public_ip[1]}\nroot@${module.gcp.gcp_public_ip}"
}
