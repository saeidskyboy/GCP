# #since the control plane is fully managed by google we just need to take care of the worker nodes

# resource "google_compute_subnetwork" "private-subnet" {
# name = "private-subnet"
# ip_cidr_range = "10.0.0.0/18" #k8s NODEs will use IPs from the main CIDR range
# region = "us-central1"
# network = google_compute_network.vpc-gke.id
# private_ip_google_access = true #we can get access to our VMs from the outside via google API without having external IP address  

# #k8s PODs will use IPs from the secondary CIDR range 
# secondary_ip_range {
#   range_name    = "k8s-pods-range" #we will use this name in our GKE config
#   ip_cidr_range = "10.48.0.0/14"
# }

# secondary_ip_range {         #when we create regular service in k8s we will use IPs from this CIDR range
#   range_name    = "k8s-service-range" #we will use this name in our GKE config
#   ip_cidr_range = "10.52.0.0/20"
# }
# }