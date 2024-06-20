output "instance_public_ip" {
    value = google_compute_instance.creating-e2-instance.network_interface.0.access_config.0.nat_ip  
}

output "instance_public_dns" {
    value = google_compute_instance.creating-e2-instance.network_interface.0.access_config.0.instance_public_dns
}