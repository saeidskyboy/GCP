# File: ssh-key-gen.tf

# Generate the ED25519 key pair
resource "tls_private_key" "ansible_ssh" {
  algorithm = "ED25519"
}

# --- Secret Manager setup for Private Key ---

# Define the secret container
resource "google_secret_manager_secret" "ansible_private_key_secret" {
  provider  = google.oslogin_admin # Use aliased provider
  secret_id = "ansible-ssh-private-key" # Provide a name for the secret
  project   = var.gcp_project_id 

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
    }
  }

  labels = {
    managed-by = "terraform"
    purpose    = "ansible-controller-ssh"
  }
  depends_on = [
    google_project_service.secretmanager_api
  ]
}
# Add the private key as a secret version
resource "google_secret_manager_secret_version" "ansible_private_key_version" {
  provider    = google.oslogin_admin # Use aliased provider
  secret      = google_secret_manager_secret.ansible_private_key_secret.id
  secret_data = tls_private_key.ansible_ssh.private_key_pem

  # Ensure this depends on the secret resource existing
  depends_on = [google_secret_manager_secret.ansible_private_key_secret]
}

# --- Permissions for Ansible Controller VM Service Account ---

# Grant the VM's service account access to read the secret version
# This block is intended to grant permission to read the private key stored in Secret Manager (ansible-ssh-private-key).
resource "google_secret_manager_secret_iam_member" "ansible_vm_secret_accessor" {
  provider    = google.oslogin_admin # Use aliased provider
  project   = google_secret_manager_secret.ansible_private_key_secret.project
  secret_id = google_secret_manager_secret.ansible_private_key_secret.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.gcp_sa_email}"

  # Ensure this depends on the secret resource existing
  depends_on = [google_secret_manager_secret.ansible_private_key_secret]
}