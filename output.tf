output "login" {
        value = "admin"
}
output "password" {
        value = "P@ssw0rd"
}
output "externalip" {
        value = "https:// ${join(" ", google_compute_instance.vm.*.network_interface.0.access_config.0.nat_ip)}"
}
