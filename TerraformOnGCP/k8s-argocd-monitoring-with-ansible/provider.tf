# https://developer.hashicorp.com/terraform/language/backend/gcs

terraform {
  backend "gcs" {
    bucket = "store-saeid-gke-statefiles-simu"
    prefix = "terraform/simu/simu.tfstate"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
    # since we are going to generate the SSH key pair using Terraform so we need to have the tls provider
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  project = "cloud-2255"
  region  = "us-central1"
}

resource "google_project_service" "secretmanager_api" {
  project = "cloud-2255"
  service = "secretmanager.googleapis.com"
  # Keep API enabled even when Terraform destroys other resources
  disable_on_destroy = false
}
