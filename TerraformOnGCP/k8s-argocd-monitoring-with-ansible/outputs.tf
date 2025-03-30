output "cluster_name" {
  value = google_container_cluster.gke-cluster.name
}

output "cluster_region" {
  value = google_container_cluster.gke-cluster.location
}


# --- Output the public key for use elsewhere ---
output "ansible_public_key_openssh" {
  description = "The generated SSH public key for Ansible in OpenSSH format."
  value       = tls_private_key.ansible_ssh.public_key_openssh
}

output "ansible_private_key_secret_version_id" {
  description = "The resource ID of the secret version holding the private key."
  value       = google_secret_manager_secret_version.ansible_private_key_version.id
}