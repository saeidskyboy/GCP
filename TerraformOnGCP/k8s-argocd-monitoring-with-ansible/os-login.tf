# --- Ensure OS Login is Enabled at the Project Level ---
# Note: Managing project metadata requires care. This resource potentially 
# manages *all* metadata keys listed within it. If other metadata exists
# that isn't listed here, Terraform might try to remove it depending on lifecycle.
# Only include 'enable-oslogin'. Ensure no other process conflicts with this. 
resource "google_compute_project_metadata" "os_login_setting" {
  project = var.gcp_project_id
  metadata = {
    # Set OS Login to TRUE for the project
    enable-oslogin = "TRUE" 
    # DO NOT add the 'ssh-keys' item here.
    # Add any OTHER project-level metadata items you manage via Terraform here.
  }
}

# --- Grant OS Login IAM Role(s) to the Target User/SA ---
# Grant the basic login role
resource "google_project_iam_member" "os_login_user" {
  project = var.gcp_project_id
  role    = "roles/compute.osLogin"
  # Use the variable for the target user's email
  member    = "serviceAccount:${var.gcp_sa_email}"
  # Use "user:${var.target_gke_node_user_email}" if it's an user email
}

# Optional: Grant admin login role (for sudo access without password)
resource "google_project_iam_member" "os_admin_login_user" {
  project = var.gcp_project_id
  role    = "roles/compute.osAdminLogin"
  member    = "serviceAccount:${var.gcp_sa_email}" 
  # Use "user:${var.target_gke_node_user_email}" if it's an user email
}

# --- Associate the Generated Public SSH Key with the Target User via OS Login ---
resource "google_os_login_ssh_public_key" "ansible_ssh_key_oslogin" {
  project = var.gcp_project_id
  # Use the variable for the target user's email
  user    = var.target_gke_node_user_email 
  # Reference the public key generated by the tls_private_key resource
  key     = tls_private_key.ansible_ssh.public_key_openssh 

  # Ensure this depends on the key being generated
  depends_on = [tls_private_key.ansible_ssh]
}