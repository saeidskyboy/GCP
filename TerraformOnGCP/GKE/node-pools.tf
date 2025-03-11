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
    disk_size_gb = 50
    labels = {
      role = "general"
    }
    # Add the network tags.  This is the crucial fix!
    tags = [
  "gke-${google_container_cluster.gke-cluster.name}-${length(split("/", google_container_cluster.gke-cluster.id)) > 1 ? element(split("/", google_container_cluster.gke-cluster.id), length(split("/", google_container_cluster.gke-cluster.id)) - 1) : google_container_cluster.gke-cluster.id}-node"
]
    service_account = "terraform@cloud-2255.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}