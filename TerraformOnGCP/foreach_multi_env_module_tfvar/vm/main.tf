# resource "google_compute_instance" "vm_instance" {
#   count        = length(var.instance_names)
#   name         = var.instance_names[count.index]
#   machine_type = var.machine_type
#   zone         = var.zones[count.index]

#   boot_disk {
#     initialize_params {
#       image = var.image
#     }
#   }
#   network_interface {
#     subnetwork = var.subnet_ids[count.index]
#   }

#   metadata = {
#     environment = terraform.workspace
#   }
# }