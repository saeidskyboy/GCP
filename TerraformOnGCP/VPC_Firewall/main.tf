# we need to have admission (in service account add the "compute network admin")

resource "google_compute_network" "auto-vpc-tf" {
  name                    = var.auto-vpc-tf
  auto_create_subnetworks = true
}

resource "google_compute_network" "custome-vpc-tf" {
  name                    = var.cus-vpc-tf
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub-4-tf" {
  name                     = var.sebnet-for-custome-vpc
  network                  = google_compute_network.custome-vpc-tf.id
  region                   = var.regions-for-custom-vpc
  ip_cidr_range            = var.ip-cidr-range-tf
  private_ip_google_access = true
}

# define firewall rules ===>>> to be able do this we need "compute security admin" role on our service account
resource "google_compute_firewall" "my-firewall" {
  name    = var.firewall-rules
  network = google_compute_network.auto-vpc-tf.id

  source_ranges = ["0.0.0.0/0"] # in production we dont use this range formate
  priority      = 800           # the default is 1000, if we want higher priority use lower number

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080"]
  }
}
