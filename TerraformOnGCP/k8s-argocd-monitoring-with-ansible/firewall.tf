# # usually we don't need to create any firewall rules for GKE, since the control plane is fully managed by google
# # just as an example and practice for my hands on experience
# # referrence doc: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

# resource "google_compute_firewall" "allow-ssh" {
#     name    = "allow-ssh"
#     network = google_compute_network.vpc-gke.id
#     allow {
#         protocol = "tcp"
#         ports    = ["22"]
#     }
#     source_ranges = ["0.0.0.0/0"]
  
# }