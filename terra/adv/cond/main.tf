provider "aws" {
	region = "eu-central-1"
}

resource "aws_vpc" "myvpc" {
        instance_tenancy = "default"
        enable_dns_support = var.dns_support == true ? true : false
        enable_dns_hostnames = "true"
	cidr_block = "10.1.0.0/16"
	tags = {
		Name = "myVPC"
		Env = var.environment
	}
}

variable "dns_support" {
	type = bool
	default = true
}

variable "environment" {
	type = string
	default = "PRD"
}
