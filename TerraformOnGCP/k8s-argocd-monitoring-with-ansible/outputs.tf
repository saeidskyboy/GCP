output "cluster_name" {
  value = google_container_cluster.gke-cluster.name
}

output "cluster_region" {
  value = google_container_cluster.gke-cluster.location
}

# --- Output the SSH Key Information ---
output "ssh_public_key_fingerprint" {
  description = "Fingerprint of the SSH public key uploaded to OS Login"
  value       = google_os_login_ssh_public_key.ssh_sa_key.fingerprint
}

# Output for Debugging and Access 
output "ssh_private_key_secret_name" {
  value       = google_secret_manager_secret.ansible_private_key_secret.name
  description = "The name of the Secret Manager secret storing the SSH private key"
}
