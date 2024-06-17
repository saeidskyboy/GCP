terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project     = "cloud-2255"
  region      = "us-cenetral1"
  credentials = var.key-pair
}
