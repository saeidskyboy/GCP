resource "google_compute_network" "vpc-gke" {
  name = "vpc-network"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
  mtu = 1460 #this is maximum trans,ission unit in bytes which the min is 1460
  delete_default_routes_on_create = false # this will prevent the default route from being created
}
