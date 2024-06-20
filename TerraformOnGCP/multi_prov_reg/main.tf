resource "google_compute_network" "vpc" {
  name                    = var.google_compute_network
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "sub1" {
  name          = "subnet1"
  region        = var.London
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.sub1_cidr_range
  depends_on    = [google_compute_network.vpc]
}

resource "google_compute_subnetwork" "sub2" {
  name          = "subnet2"
  region        = var.Dallas
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.sub2_cidr_range
  depends_on    = [google_compute_network.vpc]
}

resource "google_compute_firewall" "web-firewall" {
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

resource "google_compute_instance" "vm1" {
  name         = "vm1"
  machine_type = var.machine_type
  zone         = "${var.London}-a"
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.sub1.id
  }
}

resource "google_compute_instance" "vm2" {
  name         = "vm2"
  machine_type = var.machine_type
  zone         = "${var.Dallas}-a"
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.sub2.id
  }
}
