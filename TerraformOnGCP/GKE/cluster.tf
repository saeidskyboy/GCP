# resource doc: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster

resource "google_container_cluster" "gke-cluster" {
    name = "gke-cluster"
    location = "us-central1-f" # two options: regional or zone if we specify a region then GKE will create high availability cluster cluster in multiple zones i nthat region
    network = google_compute_network.vpc-gke.self_link
    subnetwork = google_compute_subnetwork.private-subnet.self_link
    remove_default_node_pool = true
    initial_node_count = 1
    #these two services (logging and monitoring can cost you alot, be careful and keep an eye on your billing)
    logging_service = "logging.googleapis.com/kubernetes" # this option will deploy a fluentbit container to each node and forward logs to a google cloud loggin service
    monitoring_service = "monitoring.googleapis.com/kubernetes"
    networking_mode = "VPC_NATIVE"
    # depends_on = [ google_project_service.container ]
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
      cluster_secondary_range_name = "k8s-pods-range"
      services_secondary_range_name = "k8s-service-range"
    }
    # this will make our cluster private, this will use only private IPs from our private subnet for the k8s nodes
    private_cluster_config {
      enable_private_nodes = true
      enable_private_endpoint = false # if we have a VPN setup to connect to k8s cluster we need set this option to "true"    
    master_ipv4_cidr_block = "172.16.0.0/28" #this CIDR range is used for the k8s control plane and since google is managing the control plane in their network and establish a peering connection to our VPC we dont need to specify it
    }
    deletion_protection = false
}