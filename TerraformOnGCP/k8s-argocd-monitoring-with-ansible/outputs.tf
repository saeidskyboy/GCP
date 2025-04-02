output "cluster_name" {
  value = google_container_cluster.gke-cluster.name
}

output "cluster_region" {
  value = google_container_cluster.gke-cluster.location
}

# Output for Debugging and Access
output "ssh_private_key_secret_name" {
  value       = google_secret_manager_secret.ansible_private_key_secret.name
  description = "The name of the Secret Manager secret storing the SSH private key"
}

output "os_login_status" {
  description = "Status of OS Login enablement"
  value = try(data.google_compute_project_metadata_item.os_login.value,
  try(google_compute_project_metadata_item.os_login_enabled[0].value, "UNKNOWN"))
}
