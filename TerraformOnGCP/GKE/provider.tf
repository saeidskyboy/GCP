# https://developer.hashicorp.com/terraform/language/backend/gcs

terraform {
  backend "gcs" {
    bucket = "store-saeid-gke-statefiles-simu"
    prefix = "terraform/simu/simu.tfstate"
    # credentials = "./keys.json" # comment this parameter if you are using a GH CI/CD and gh secrets
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
  # credentials = "./keys.json" # comment this parameter if you are using a GH CI/CD and GH secrets 
  }