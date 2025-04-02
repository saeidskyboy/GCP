# --- Ensure OS Login is Enabled at the Project Level ---
# Note: Managing project metadata requires care. This resource potentially 
# manages *all* metadata keys listed within it. If other metadata exists
# that isn't listed here, Terraform might try to remove it depending on lifecycle.
# Only include 'enable-oslogin'. Ensure no other process conflicts with this. # File: os-login.tf

# --- Enable OS Login at the Project Level ---

# Check for existing OS Login metadata
data "google_compute_project_metadata" "existing_metadata" {
  project = var.gcp_project_id
}

# Only create OS Login metadata if it doesn't already exist
resource "google_compute_project_metadata_item" "os_login_enabled" {
  # Skip creation if it already exists
  count = contains(keys(data.google_compute_project_metadata.existing_metadata.metadata), "enable-oslogin") ? 0 : 1

  project = var.gcp_project_id
  key     = "enable-oslogin"
  value   = "TRUE"
}

# Output the SSH Key Information for verification
output "ssh_sa_email" {
  description = "Email of the service account used for SSH"
  value       = var.ssh_sa_email
}
