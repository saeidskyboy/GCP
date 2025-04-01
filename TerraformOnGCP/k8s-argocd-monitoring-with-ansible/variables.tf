# File: variables.tf

variable "gcp_project_id" {
  type        = string
  description = "The GCP Project ID where resources will be deployed."
}

variable "gcp_sa_email" {
  type        = string
  description = "Email address of the Service Account used to create and deploy resources."
}

variable "ssh_sa_email" {
  type        = string
  description = "Email address of the Service Account used to creat ssh keys."
}
