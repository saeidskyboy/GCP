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
  }
}

provider "google" {
  project     = "cloud-2255"
  region      = "us-cenetral1"
  }