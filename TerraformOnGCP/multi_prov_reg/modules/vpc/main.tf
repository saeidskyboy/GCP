# modules/vpc/main.tf

resource "google_compute_network" "vpc" {
  name                    = var.google_compute_network
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = var.subnets
  name          = each.key
  region        = each.value.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = each.value.ip_cidr_range
}

resource "google_compute_firewall" "web_firewall" {
  name      = "coming-from-terraform"
  network   = google_compute_network.vpc.id
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
}

resource "google_compute_firewall" "internal_egress" {
  name      = "allow-internal-egress"
  network   = google_compute_network.vpc.id
  direction = "EGRESS"
  allow {
    protocol = "all"
  }
  destination_ranges = ["10.0.0.0/16"]
}

# Outputs
output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "The ID of the VPC network"
}

output "subnet_ids" {
  value = {
    for k, v in google_compute_subnetwork.subnets :
    k => v.id
  }
  description = "Map of subnet names to their IDs"
}
