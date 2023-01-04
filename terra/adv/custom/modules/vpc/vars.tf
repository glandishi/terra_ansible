#Define Variable for Custom Module VPC

variable "AWS_REGION" {
    type    = string
    default = "eu-central-1"
}

variable "ENVIRONMENT" {
    type    = string
    default = ""
}
