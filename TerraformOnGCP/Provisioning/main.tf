# still is not working, needs debugging

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project     = "cloud-2255"
  region      = "us-central1"
  credentials = "./keys.json"
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_router" "nat_router" {
  name    = "my-router"
  region  = "us-central1"
  network = google_compute_network.vpc_network.id

}

resource "google_compute_router_nat" "nat_config" {
  name                               = "my-nat"
  router                             = google_compute_router.nat_router.name
  region                             = google_compute_router.nat_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  #   subnetwork {
  #     name = google_compute_subnetwork.vpc_subnetwork.id
  #     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  #   }
}

resource "google_compute_firewall" "web_firewall" {
  name    = "terraform-firewall-allow-http-ssh"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "server" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  metadata = {
    user-data = file("${path.module}/cloud-init.yaml")
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_network.vpc_network.id
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_project_metadata_item" "ssh_key" {
  key   = "ssh-keys"
  value = "saeid:${file("~/.ssh/id_rsa.pub")}"
}