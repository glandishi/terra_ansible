provider "google" {
	credentials = file("~/ansible/ansible_automation/lab/gcp.json")
	project = "k8s-gcp-370918"
	region = "us-east1"
	zone = "us-east1-c"
}

resource "google_compute_network" "vpc_network" {
	name = "practice-network"
	auto_create_subnetworks = "true"
}

