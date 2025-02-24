terraform {
  required_version = ">= 1.5.0"
  cloud { #within this block our state file will be stored in TF cloud in GCP workspace
    organization = "project-2255"
    workspaces {
      name = "GCP"
    }
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.33.0"
    }
  }
}


provider "google" {
  project = "cloud-2255"
  credentials = "./keys.json"
}
# resource "google_compute_network" "default" {
#   name = "default"
  
# }

# resource "google_compute_instance" "vm1" {
#   name = "vm1"
#   machine_type = "e2-micro"
#   zone = "us-central1-c"
#   # network_interface {
#   #   network = "default"
#   # }
#   # boot_disk {
#   #   initialize_params {
#   #     image = "debian-cloud/debian-11"
#   #   }
#   # }
# }

# resource "google_compute_instance" "vm2" {
#   name = "vm2"
#   machine_type = "e2-micro"
#     zone = "us-central1-c"

#   # network_interface {
#   #   network = "default"
#   # }
#   # boot_disk {
#   #   initialize_params {
#   #     image = "debian-cloud/debian-11"
#   #   }
#   # }
# }


# resource "google_compute_instance" "vm3" {
#   name = "vm3"
#   machine_type = "e2-micro"
#     zone = "us-central1-c"

#   # network_interface {
#   #   network = "default"
#   # }
#   # boot_disk {
#   #   initialize_params {
#   #     image = "debian-cloud/debian-11"
#   #   }
#   # }
# }
