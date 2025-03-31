# usually we don't need to create any firewall rules for GKE, since the control plane is fully managed by google
# just as an example and practice for my hands on experience
# referrence doc: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

resource "google_compute_firewall" "allow-ssh" {
    name    = "allow-ssh"
    network = google_compute_network.vpc-gke.id
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = ["0.0.0.0/0"]
  
}

resource "google_compute_firewall" "allow_ssh_from_ansible_controller" {
  name      = "allow-ssh-from-ansible-controller"
  network   = google_compute_network.vpc-gke.id
  direction = "INGRESS"
  priority  = 1000 

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["ansible-controller"]
  target_tags = ["gke-gke-cluster-ff3880f9-node"]
}