# resource "google_compute_network" "vpc-gke" {
#   name = "vpc-network"
#   routing_mode = "REGIONAL"
#   auto_create_subnetworks = false
#   mtu = 1460 #this is maximum trans,ission unit in bytes which the min is 1460
#   delete_default_routes_on_create = false # this will prevent the default route from being created
# }

# # Add to your network configuration file(s)
# # Peering from vpc-network TO vpc-ansible
# # establish VPC Network Peering between vpc-ansible and vpc-network.
# # This requires creating peering configurations on both networks

# # Peering from vpc-ansible TO vpc-network
# resource "google_compute_network_peering" "peering_ansible_to_gke" {
#   name         = "peer-ansible-to-gke-vpc"
#   network      = google_compute_network.vpc_ansible.id
#   peer_network = google_compute_network.vpc-gke.id
# }

# # Peering from vpc-network TO vpc-ansible
# resource "google_compute_network_peering" "peering_gke_to_ansible" {
#   name         = "peer-gke-vpc-to-ansible"
#   network      = google_compute_network.vpc-gke.id
#   peer_network = google_compute_network.vpc_ansible.id
# }