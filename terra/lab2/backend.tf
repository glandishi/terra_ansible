terraform {
	backend "s3" {
		bucket = "tf-state-11abc"
		key = "dev/terraform_state"
		region = "us-east-1"
	}
}
