# terraform {
#   required_version = ">= 1.5.0"
#   cloud { #within this block our state file will be stored in TF cloud in vm-vpc-module workspace
#     organization = "project-2255"
#     workspaces {
#       name = "vm-vpc-module"
#     }
#   }

#   required_providers {
#     google = {
#       source = "hashicorp/google"
#       version = "5.33.0"
#     }
#   }
# }

provider "google" {
  project = "cloud-2255"
  credentials = "./keys.json"
}

module "vpc" {
  source            = "./vpc"
  vpc_name          = "my-custom-vpc"
  subnet_name       = "my-subnet"
  subnet_ip_range   = "10.0.1.0/24"
  subnet_region     = "us-central1"  
}

module "vm" {
  source          = "./vm"
  instance_name   = "my-vm-instance"
  machine_type    = "e2-micro"  
  zone            = "us-central1-a"
  image           = "debian-cloud/debian-11"
  subnet_id       = module.vpc.subnet_id
}
