# main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project = "cloud-2255"
  region  = "us-central1"
  #   zone        = "us-central1-f"
  credentials = "./keys.json"
}

# Variables
variable "credentials_path" {
  type        = string
  description = "Path to the service account credentials file (JSON)"
}

variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID"
}

module "vpc" {
  source                  = "./modules/vpc"
  google_compute_network  = "my-vpc"
  auto_create_subnetworks = false
  subnets = {
    subnet1 = { region = "europe-west2", ip_cidr_range = "10.0.0.0/24" }
    subnet2 = { region = "us-south1", ip_cidr_range = "10.0.1.0/24" }
  }
}

module "vm" {
  source     = "./modules/vm"
  network_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  instances = {
    vm1 = { zone = "europe-west2-a", machine_type = "e2-micro", image = "debian-cloud/debian-11", subnet = "subnet1" }
    vm2 = { zone = "us-south1-a", machine_type = "e2-medium", image = "debian-cloud/debian-11", subnet = "subnet2" }
  }
}
