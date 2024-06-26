# modules/vm/main.tf

resource "google_compute_instance" "vms" {
  for_each      = var.instances
  name          = each.key
  machine_type = each.value.machine_type
  zone         = each.value.zone
  boot_disk {
    initialize_params {
      image = each.value.image
    }
  }
  network_interface {
    network    = var.network_id
    subnetwork = var.subnet_ids[each.value.subnet]
  }
}
