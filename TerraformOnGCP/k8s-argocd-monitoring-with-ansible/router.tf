# #we will advertise routes, it will be used with the NAT gateway to allow VMs without IPs address to access the internet e.g. pull the docker images from docker hub etc
# # document to use: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
# resource "google_compute_router" "router" {
#     name = "router"
#     region = "us-central1"
#     network = google_compute_network.vpc-gke.id
# }

# #natting - doc: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
# resource "google_compute_router_nat" "nat" {
#     name = "nat"
#     router = google_compute_router.router.name
#     region = "us-central1"
#     nat_ip_allocate_option = "MANUAL_ONLY"
#     nat_ips = ["${google_compute_address.nat.self_link}"] # since we allocate our own IP address for the cloud NAT we need to specify it here
#     source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" #we can decide to advertise this cloud NAT to all subnet in VPC

# subnetwork {
#     name = google_compute_subnetwork.private-subnet.id
#     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
# }
# }

# resource "google_compute_address" "nat" {
#     name = "nat"
#     region = "us-central1"
#     network_tier = "PREMIUM"
#     address_type = "EXTERNAL"
#     # depends_on = [ google_project_service.compute ]
# }
