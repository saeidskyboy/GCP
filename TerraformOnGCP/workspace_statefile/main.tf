terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.34.0"
    }
  }
}

provider "google" {
  project     = "cloud-2255"
  region      = "us-central1"
  credentials = "./keys.json"
}

variable "machine_type" {
  description = "define what machine type for each workspace"
  type        = map(string)
  default = {
    "dev" = "e2-micro"
    simu  = "e2-medium"
    stage = "e2-small"
    prod  = "e2-standard-16"
  }
}

variable "image" {
  description = "value of image"
  type        = string
}

module "machine_type" {
  source       = "./modules/vm"
  machine_type = lookup(var.machine_type, terraform.workspace, "e2-micro")
  image        = var.image
}