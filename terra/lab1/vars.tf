variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAURLOCCNS7IOK5SHM"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "us-east-2"
}

variable "Security_Group"{
    type = list
    default = ["sg-03d6505df4209babe"]
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0f40c8f97004632f9"
        us-east-2 = "ami-05692172625678b4e"
        us-west-2 = "ami-0352d5a37fb4f603f"
        us-west-1 = "ami-0f40c8f97004632f9"
    }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "andy.key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "andy.key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
