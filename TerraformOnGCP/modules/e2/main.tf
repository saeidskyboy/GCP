resource "google_compute_instance" "creating-e2-instance" {
    name = var.instance_name
    machine_type = var.machine_type
    boot_disk {
        initialize_params {
            image = var.image
        }
    }
    
tags = ["tag1", "tag2"]
}