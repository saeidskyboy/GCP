# https://developer.hashicorp.com/terraform/language/backend/gcs

terraform {
  backend "gcs" {
    bucket = "store-saeid-gke-statefiles-simu"
    prefix = "terraform/simu/simu.tfstate"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
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
  project     = var.gcp_project_id 
  region      = "us-cenetral1"
  }