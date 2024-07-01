# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "5.33.0"
#     }
#   }
# }

# provider "google" {
#   project     = "cloud-2255"
#   region      = "us-central1"
# #   zone        = "us-central1-f"
# credentials = file(module.vpc.credentials_path)
# }

# provider "google" {
#   alias  = "Dallas"
#   region = "us-south1"
# }

# provider "google" {
#   alias  = "Frankfurt"
#   region = "europe-west3"
# }

# provider "google" {
#   alias  = "London"
#   region = "europe-west2"
# }
