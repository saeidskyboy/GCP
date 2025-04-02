# --- Ensure OS Login is Enabled at the Project Level ---
# Note: Managing project metadata requires care. This resource potentially 
# manages *all* metadata keys listed within it. If other metadata exists
# that isn't listed here, Terraform might try to remove it depending on lifecycle.
# Only include 'enable-oslogin'. Ensure no other process conflicts with this. # File: os-login.tf

# --- Enable OS Login at the Project Level ---

# File: os-login.tf

# Get current project metadata
data "google_compute_project_metadata_item" "os_login" {
  project = var.gcp_project_id
  key     = "enable-oslogin"
  # This will fail if the metadata doesn't exist, which we'll handle with try()
}

# Create OS Login metadata if it doesn't exist
resource "google_compute_project_metadata_item" "os_login_enabled" {
  # Only create if the data lookup failed (metadata doesn't exist)
  count = try(data.google_compute_project_metadata_item.os_login.value, "") == "" ? 1 : 0

  project = var.gcp_project_id
  key     = "enable-oslogin"
  value   = "TRUE"
}
