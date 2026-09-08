output "nat_external_ip" {
  value = yandex_compute_instance.nat-instance.network_interface.0.nat_ip_address
}

output "public_external_ip" {
  value = yandex_compute_instance.public-vm.network_interface.0.nat_ip_address
}

output "private_internal_ip" {
  value = yandex_compute_instance.private-vm.network_interface.0.ip_address
}
