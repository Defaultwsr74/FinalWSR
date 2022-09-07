terraform {
	required_providers {
		google = {
			source = "hashicorp/google"	
			version = "~>4.0"
		}
	}
}

provider "google" {
	credentials = file("creds.json")
	project = var.gcp_project
	region = var.gcp_region
	zone = var.gcp_zone
}

variable "gcp_region" {
	type = string
	default	= "us-central1"
}

variable "gcp_project" {
	type = string
	default	= " ... "
}

variable "vm_name" {
	type = string
	description = "Please enter name"
	default = "cml"
}

variable "gcp_zone" {
	type = string
	default = "us-central1-a"
}
variable "vm_count" {
	description = "Please enter number"
}

resource "google_compute_instance" "vm" {
	count = var.vm_count
	name = "${var.vm_name}-${count.index}"
	zone = var.gcp_zone
	tags = ["https-server", "cml-console", "cml-ssh"]

	machine_type = "e2-standard-4"

	boot_disk {
		initialize_params {
			image = "image-1"
		}
	}

	network_interface {
		network = "default"
		access_config {
		}
	}
}

resource "google_compute_firewall" "cml-rule" {
	name = "cml-console"
  	network = "default"
  	allow {
		protocol = "tcp"
    		ports = ["9090"]
  	}
	target_tags = ["cml-console"]
  		source_ranges = ["0.0.0.0/0"]
	}

resource "google_compute_firewall" "ssh-rule" {
  	name = "cml-ssh"
  	network = "default"
  	allow {
    		protocol = "tcp"
    		ports = ["22"]
  	}
	target_tags = ["cml-ssh"]
  	source_ranges = ["0.0.0.0/0"]
}
output "login" {
	value = "admin"
}
output "password" {
	value = "P@ssw0rd"
}
output "externalip" {
	value = "https:// ${join(" ", google_compute_instance.vm.*.network_interface.0.access_config.0.nat_ip)}"
}
