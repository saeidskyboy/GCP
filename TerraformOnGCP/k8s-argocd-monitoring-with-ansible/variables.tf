# File: variables.tf

variable "gcp_project_id" {
  type        = string
  description = "The GCP Project ID where resources will be deployed."
}

variable "gcp_sa_email" {
  type        = string
  description = "Email address of the Service Account used by the Ansible Controller VM."
}

# ust correspond to an existing Google Account (like a Google Workspace user, a Cloud Identity user, or a GCP Service Account)
# that you intend for Ansible to use when connecting to the nodes.
variable "target_gke_node_user_email" {
  type        = string
  description = "The Google account email (user or service account) that Ansible will use to log into GKE nodes via OS Login."
  # Example value: "your-google-user@yourdomain.com" or "ansible-runner-sa@your-project.iam.gserviceaccount.com"
}