# --- Ensure OS Login is Enabled at the Project Level ---
# Note: Managing project metadata requires care. This resource potentially 
# manages *all* metadata keys listed within it. If other metadata exists
# that isn't listed here, Terraform might try to remove it depending on lifecycle.
# Only include 'enable-oslogin'. Ensure no other process conflicts with this. # File: os-login.tf

# --- Enable OS Login at the Project Level ---
resource "google_compute_project_metadata_item" "os_login_enabled" {
  project = "cloud-2255"
  key     = "enable-oslogin"
  value   = "TRUE"
}

# --- Associate the Generated SSH Key with the Service Account via OS Login ---
resource "google_os_login_ssh_public_key" "ssh_sa_key" {
  project = "cloud-2255"
  user    = var.ssh_sa_email # Using the email from GitHub secrets
  key     = tls_private_key.ansible_ssh.public_key_openssh
  depends_on = [
    tls_private_key.ansible_ssh
  ]
}
