# resource doc: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster 

resource "google_container_cluster" "gke-cluster" {
  name                     = "gke-cluster"
  location                 = "us-central1-f"
  network                  = google_compute_network.vpc-gke.self_link
  subnetwork               = google_compute_subnetwork.private-subnet.self_link
  remove_default_node_pool = true
  initial_node_count       = 1

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  networking_mode    = "VPC_NATIVE"

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "cloud-2255.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pods-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes   = true
    enable_private_endpoint = false # Set to true if using private endpoint
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  deletion_protection = false
}
resource "google_project_iam_member" "ns-permission" {
  project = "cloud-2255"
  role       = "roles/container.clusterAdmin"
  member = "serviceAccount:terraform@cloud-2255.iam.gserviceaccount.com"
}

output "cluster_id" {
  value = google_container_cluster.gke-cluster.id
  
}