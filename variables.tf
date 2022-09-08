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
