# --- Add Public Key to Project Metadata for GKE Node Access ---
# WARNING: This assumes GKE nodes use project metadata SSH keys.
# Adjust if using OS Login or other methods. This also MERGES keys.

# DATA SOURCE to read project info, including metadata
data "google_compute_project_info" "default" {} 

# RESOURCE block to manage/update the project metadata
resource "google_compute_project_metadata" "project_metadata_with_ansible_key" {
  project = var.gcp_project_id

  metadata = {
    # Merge new key with existing ssh-keys metadata
    ssh-keys = join("\n", compact(distinct(concat(
      # Reference the CORRECT data source attribute here
      split("\n", lookup(data.google_compute_project_info.default.metadata, "ssh-keys", "")), 
      ["root:${tls_private_key.ansible_ssh.public_key_openssh} ansible-controller"] # Add key for root user
    ))))

    # IMPORTANT NOTE: Remember to handle preservation of other metadata keys
    # enable-oslogin = lookup(data.google_compute_project_info.default.metadata, "enable-oslogin", null)
    # ... other keys ...
  }

# --- IMPORTANT CAVEATS ---
# 1. If your GKE nodes block project metadata SSH keys, this won't work.
# 2. If you use OS Login, you need to use google_os_login_ssh_public_key instead.
# 3. Merging metadata keys like this can be fragile. Manage all required keys explicitly
#    within this resource or use dedicated modules for metadata management.
}