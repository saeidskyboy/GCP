provider "google" {
  project = "cloud-2255"
  credentials = "./keys.json"
  
}

data "google_compute_network" "my_netw" {
  name = "vpc34"
}

output "vpc-in-gcp" {
    value = data.google_compute_network.my_netw
  
