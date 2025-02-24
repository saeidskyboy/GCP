# resource doc: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

# resource "google_service_account" "gke_node_sa" {
#   account_id   = "gke-node-sa"
#   display_name = "Service Account for GKE Node Pool"
#   project = "cloud-2255"
# }

resource "google_container_node_pool" "general" {
    name = "node-pool"
    cluster = google_container_cluster.gke-cluster.id
    node_count = 1

    management {
        auto_repair = true
        auto_upgrade = true
    }
    node_config {
        preemptible = true #it is better to set as falese if you have enough quota
        machine_type = "e2-micro"
        disk_size_gb = 10
        labels = {
            role = "general"
        }

        service_account = "terraform@cloud-2255.iam.gserviceaccount.com"
        oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
        }
}


resource "google_container_node_pool" "spot" {
  name = "spot-pool"
  cluster = google_container_cluster.gke-cluster.id

  management {
    auto_repair = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  node_config {
    preemptible = true
    labels = {
     team = "devops"
     }
        # with this config block we avoid of accidental scheduling of nodes
    taint {
      key = "instance_type"
      value = "spot"
      effect = "PREFER_NO_SCHEDULE"
    }

    service_account = "terraform@cloud-2255.iam.gserviceaccount.com"
        oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }
}