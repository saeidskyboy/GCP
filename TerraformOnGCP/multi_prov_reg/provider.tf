terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project     = var.project-id
  region      = var.Dallas
  zone        = "us-central1-f"
  credentials = var.credentials
}

provider "google" {
  alias  = "Dallas"
  region = "us-south1"
}

provider "google" {
  alias  = "Frankfurt"
  region = "europe-west3"
}

provider "google" {
  alias  = "London"
  region = "europe-west2"
}
