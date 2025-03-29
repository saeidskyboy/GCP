#enabling certain service API use this resource: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service

# resource "google_project_service" "compute" {
#     service = "compute.googleapis.com"
#   disable_on_destroy = false
# }

# resource "google_project_service" "container" {
#     service = "container.googleapis.com"
#   disable_on_destroy = false
# }

#vpc creation config block

resource "google_compute_network" "vpc-gke" {
  name = "vpc-network"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
  mtu = 1460 #this is maximum trans,ission unit in bytes which the min is 1460
  delete_default_routes_on_create = false # this will prevent the default route from being created
  #here we explicitly mention that this resource depends on enabling below service which they need to be executed first
  # depends_on = [ 
  #   google_project_service.compute,
  #   google_project_service.container
  #   ]
}
