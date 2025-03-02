# this output will pass info to make sure that indicates the cluster's existence
# so we we don't need rerun this workflow in GH
# TerraformOnGCP/GKE/outputs.tf
output "cluster_name" {
  value = google_container_cluster.gke-cluster.name
}

output "cluster_region" {
  value = google_container_cluster.gke-cluster.location
}