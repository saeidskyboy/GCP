# resource doc: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

resource "google_container_node_pool" "primary_nodes" {
  name               = "primary-node-pool"
  cluster            = google_container_cluster.gke-cluster.id
  location           = google_container_cluster.gke-cluster.location
  initial_node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    disk_size_gb = 20
    labels = {
      role = "general"
    }

    service_account = "terraform@cloud-2255.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}