provider "google" {
  project = "cloud-2255"
  region  = "us-central1"
  credentials = "./keys.json"          # disable this credential if you are willing to run github action with terraform since we are using github secret token instead to run the workflow action events
}

variable "image" {
  description = "this is an image for our instance"
}

variable "machine_type" {
  description = "this is a machine type for our instance"
}

resource "google_compute_instance" "my-vm" {
  count = 4
  name         = "my-vm-22-s-${terraform.workspace}${count.index}"
  zone         = "us-central1-a"
  machine_type = var.machine_type
  network_interface {
    network = "my-vpc-22-s"
  }
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
}
