provider "google" {
	credentials = file("gcp/gcp.json")
	project = "k8s-gcp-370918"
	region = var.gcp_region
	zone = "${var.gcp_region}-a"
}

variable "gcp_region" {
	type = string
	default = "europe-central2"
}

resource "google_compute_network" "vpc_network" {
	name = "practice-network"
	auto_create_subnetworks = true
}

resource "google_compute_firewall" "allow_lab" {
  name    = "ansible-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["165.232.68.132/32","37.8.230.60/32"]
}

resource "google_compute_instance" "ansible_gcp" {
  name         = "ansible"
  machine_type = "f1-micro"
  zone         = "${var.gcp_region}-a"
  allow_stopping_for_update = true
  tags = ["type", "ansible"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 20
      labels = {
        my_label = "value"
      }
    }
  }
  network_interface {
    network = "practice-network"
    access_config {
      nat_ip = ""
    }
  }
  depends_on = [
    google_compute_network.vpc_network
  ]
}

output "gcp_public_ip" {
	value = google_compute_instance.ansible_gcp.network_interface.0.access_config.0.nat_ip
}
