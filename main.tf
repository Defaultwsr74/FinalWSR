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

resource "google_compute_instance" "vm" {
	count = var.vm_count
	name = "${var.vm_name}-${count.index}"
	zone = var.gcp_zone
	tags = ["https-server", "cml-console", "cml-ssh"]

	machine_type = "e2-standard-4"

	boot_disk {
		initialize_params {
			image = " ... "
		}
	}

	network_interface {
		network = "default"
		access_config {
		}
	}
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
