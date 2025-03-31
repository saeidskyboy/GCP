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
  # Use the user format since target_gke_node_user_email holds the user email
  member  = "user:${var.target_gke_node_user_email}" 
}

# Optional: Grant admin login role (for sudo access without password)
resource "google_project_iam_member" "os_admin_login_user" {
  project = var.gcp_project_id
  role    = "roles/compute.osAdminLogin"
  # Use the user format since target_gke_node_user_email holds the user email
  member  = "user:${var.target_gke_node_user_email}" 
}

# --- Associate the Generated Public SSH Key with the Target User via OS Login ---
# This block was already correct, assuming var.target_gke_node_user_email holds the user email
resource "google_os_login_ssh_public_key" "ansible_ssh_key_oslogin" {
  project = var.gcp_project_id
  user    = var.target_gke_node_user_email 
  key     = tls_private_key.ansible_ssh.public_key_openssh 
  depends_on = [
    tls_private_key.ansible_ssh,
    # Depend on roles being granted before associating key
    google_project_iam_member.os_login_user,
    google_project_iam_member.os_admin_login_user 
  ]
}