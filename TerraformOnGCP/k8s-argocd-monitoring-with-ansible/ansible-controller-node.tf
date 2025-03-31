# resource "google_compute_network" "vpc_ansible" {
#   name                           = "vpc-ansible"
#   auto_create_subnetworks        = true
# }

# resource "google_compute_instance" "ansible_control_node" {
#   name         = "ansible-controller-node"
#   machine_type = "e2-micro"
#   zone         = "us-central1-a"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#       size  = 10
#     }
#   }

#   network_interface {
#     network = google_compute_network.vpc_ansible.id
#     access_config {
#       # Ephemeral public IP - remove this block if you don't need external access
#     }
#   }
    

#   # --- Optional: Add metadata, service accounts, tags etc. as needed ---
#   # Example: Add a tag
#   tags = ["ansible-controller"]

#  # Read the script content from the external file - it takes ~ 15 min to all scripts will be executed
#   metadata_startup_script = file("${path.module}/ansible/startup-script.sh")
  
#   # Required for deleting instances that have attached disks, useful for lifecycle mgmt 
#   allow_stopping_for_update = true
# }

# resource "google_compute_firewall" "allow-ssh-ansible" {
#     name    = "allow-ssh-ansible"
#     network = google_compute_network.vpc_ansible.id
#     allow {
#         protocol = "tcp"
#         ports    = ["22"]
#     }
#     source_ranges = ["0.0.0.0/0"] # only for test purposes only, restrict to your IP or CIDR range in production
  
# }

# output "ansible_control_node_public_ip" {
#   description = "Public IP address of the Ansible Control Node VM"
#   # Adding a check to prevent errors if access_config is removed or not yet available
#   value = try(google_compute_instance.ansible_control_node.network_interface[0].access_config[0].nat_ip, "N/A (No Public IP)")
# }

# output "ansible_control_node_private_ip" {
#   description = "Private IP address of the Ansible Control Node VM"
#   value       = google_compute_instance.ansible_control_node.network_interface[0].network_ip
# }

# output "vpc_network_name" {
#   description = "Name of the VPC network created"
#   value       = google_compute_network.vpc_ansible.name
# }

# output "vpc_network_self_link" {
#   description = "Self-link of the VPC network created"
#   value       = google_compute_network.vpc_ansible.self_link
# }