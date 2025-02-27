<<<<<<< HEAD:TerraformOnGCP/multi_env_module_tfvar/main.tf
terraform {
  cloud {
    organization = "project-2255"
    workspaces {
      name = "stage" # this block will create a workspace in TFC to save the state file and set our workspace here in local
    }
  }
  required_version = ">=1.1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.34.0"
=======
# I changed the previos config (deleted the workspaces) to try use cloud workspace state storage automat, it is not completed yet

# terraform {
#   required_version = ">= 1.5.0"
#   cloud { #within this block our state file will be stored in TF cloud in multi-env-module workspace
#     organization = "project-2255"
#     workspaces {
#       name = "dev"
#     }
#   }

  terraform{
    required_version = ">= 1.5.0"
    required_providers {
        google = {
      source = "hashicorp/google"
      version = "5.33.0"
>>>>>>> workflow:TerraformOnGCP/foreach_multi_env_module_tfvar/main.tf
    }
  }
  }

provider "google" {
  project = "cloud-2255"
<<<<<<< HEAD:TerraformOnGCP/multi_env_module_tfvar/main.tf
  region  = "us-central1"
  credentials = "./keys.json"          # disable this credential if you are willing to run github action with terraform since we are using github secret token instead to run the workflow action events
=======
  credentials = "./keys.json"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_names" {
  type        = list(string)
  description = "List of subnetwork names"
}

variable "subnet_ip_ranges" {
  type        = list(string)
  description = "List of IP CIDR ranges for the subnets"
}

variable "subnet_region" {
  type        = string
  description = "Region for the subnets (e.g., us-central1)"
}
variable "instance_names" {
  type        = list(string)
  description = "List of VM instance names"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the instances"
}

variable "zones" {
  type        = list(string)
  description = "List of zones for the instances (e.g., [\"us-central1-a\", \"us-central1-b\"])"
}

variable "image" {
  type        = string
  description = "Source image for the instances' boot disks"
>>>>>>> workflow:TerraformOnGCP/foreach_multi_env_module_tfvar/main.tf
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
