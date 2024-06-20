output "vpc-ip" {
    value = google_compute_network.vpc.id
}

output "public_ip-vm1" {
       value = google_compute_instance.vm1.network_interface.0.network_ip
}

output "public_ip-vm2" {
    value = google_compute_instance.vm2.network_interface.0.network_ip
}