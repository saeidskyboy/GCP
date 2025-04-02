# --- Ensure OS Login is Enabled at the Project Level ---
# Note: Managing project metadata requires care. This resource potentially 
# manages *all* metadata keys listed within it. If other metadata exists
# that isn't listed here, Terraform might try to remove it depending on lifecycle.
# Only include 'enable-oslogin'. Ensure no other process conflicts with this. # File: os-login.tf

# File: os-login.tf

# We'll manage the OS Login metadata as an always-present resource
resource "google_compute_project_metadata_item" "os_login_enabled" {
  project = var.gcp_project_id
  key     = "enable-oslogin"
  value   = "TRUE"

  # Prevent Terraform from trying to recreate or delete it
  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}

# Output the SSH service account email for verification
output "ssh_sa_email" {
  description = "Email of the service account used for SSH"
  value       = var.ssh_sa_email
}
