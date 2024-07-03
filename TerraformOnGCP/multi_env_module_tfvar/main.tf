terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.34.0"
    }
  }
}

provider "google" {
  project = "cloud-2255"
  region  = "us-central1"
  credentials = "./keys.json"          # disable this credential if you are willing to run github action with terraform since we are using github secret token instead to run the workflow action events
}

module "vpc" {
  source           = "./vpc"
  vpc_name         = var.vpc_name
  subnet_names     = var.subnet_names
  subnet_ip_ranges = var.subnet_ip_ranges
  subnet_region    = var.subnet_region
}

module "vm" {
  source         = "./vm"
  instance_names = var.instance_names
  machine_type   = var.machine_type
  zones          = var.zones
  image          = var.image
  subnet_ids     = module.vpc.subnet_ids
}

# dev/prod.tfvars variables: create a .tfvars file(s) with the following variables
#you need to specify the file during apply i.e. => terraform apply -var-file=dev.tfvars
# vpc_name = "custome-vpc-prod"
# subnet_names = ["subnet-test1", "subnet-t2" "subnet-c1", "subnet-c7"]
# subnet_ip_ranges = ["specify your own subnet ip ranges in these blosck as much as you want", "1.1.1.1/24", "1.1.1.1/24", "1.1.1.1/24"]
# subnet_region = "us-central1"

# instance_names = ["prod-vm-t7", "simu-vm-t7" "prod-vm-c7"]
# zones = ["us-central1-b", "us-central1-c" "us-central1-f"]
# machine_type = "your machine type"
# image = "what image you would like to use to boot your vms"
