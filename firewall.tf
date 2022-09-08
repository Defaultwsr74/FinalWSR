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
