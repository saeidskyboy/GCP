resource "google_compute_network" "vpc_ansible" {
  name                           = "vpc-ansible"
  auto_create_subnetworks        = true
}

resource "google_compute_instance" "ansible_control_node" {
  name         = "ansible-control-node"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  network_interface {
    network = google_compute_network.vpc_ansible.id
    access_config {
      # Ephemeral public IP - remove this block if you don't need external access
    }
  }
    

  # --- Optional: Add metadata, service accounts, tags etc. as needed ---
  # Example: Add a tag
  tags = ["ansible-controller"]

  # --- Startup Script ---
  # Installs prerequisites, Ansible, generates an SSH key, and outputs the public key.
  metadata_startup_script = <<-EOF
    #!/bin/bash
    set -e # Exit immediately if a command exits with a non-zero status.

    echo "### Updating package list ###"
    apt-get update -y

    echo "### Installing prerequisites: python3, pip, git ###"
    apt-get install -y python3 python3-pip git

    echo "### Installing Ansible via pip ###"
    pip3 install ansible

    echo "### Generating SSH key for Ansible Controller ###"
    # Define key path (using root's home dir as scripts often run as root)
    # If you need the key for a specific user, adjust path and permissions.
    KEY_PATH="/root/.ssh/id_ed25519_ansible_controller"
    KEY_DIR=$(dirname "$KEY_PATH")
    KEY_COMMENT="ansible-controller"

    # Ensure .ssh directory exists with correct permissions (700)
    mkdir -p "$KEY_DIR"
    chmod 700 "$KEY_DIR"

    # Generate the ed25519 key pair without a passphrase (-N '')
    # -t type, -f filename, -C comment
    # This will overwrite the key if the script runs again (e.g., instance restart with script enabled)
    ssh-keygen -t ed25519 -f "$KEY_PATH" -N '' -C "$KEY_COMMENT"

    echo "### Setting key permissions ###"
    chmod 600 "${KEY_PATH}"     # Private key readable only by owner
    chmod 644 "${KEY_PATH}.pub" # Public key readable by all

    echo "### Ansible Controller Public Key Output ###"
    echo "--- START ANSIBLE CONTROLLER PUBLIC KEY (${KEY_PATH}.pub) ---"
    cat "${KEY_PATH}.pub"
    echo "--- END ANSIBLE CONTROLLER PUBLIC KEY ---"
    echo "### Startup script finished ###"
  EOF

  # Required for deleting instances that have attached disks, useful for lifecycle mgmt
  allow_stopping_for_update = true
}

resource "google_compute_firewall" "allow-ssh" {
    name    = "allow-ssh"
    network = google_compute_network.vpc_ansible.id
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = ["0.0.0.0/0"] # only for test purposes only, restrict to your IP or CIDR range in production
  
}

output "ansible_control_node_public_ip" {
  description = "Public IP address of the Ansible Control Node VM"
  # Adding a check to prevent errors if access_config is removed or not yet available
  value = try(google_compute_instance.ansible_control_node.network_interface[0].access_config[0].nat_ip, "N/A (No Public IP)")
}

output "ansible_control_node_private_ip" {
  description = "Private IP address of the Ansible Control Node VM"
  value       = google_compute_instance.ansible_control_node.network_interface[0].network_ip
}

output "vpc_network_name" {
  description = "Name of the VPC network created"
  value       = google_compute_network.vpc_ansible.name
}

output "vpc_network_self_link" {
  description = "Self-link of the VPC network created"
  value       = google_compute_network.vpc_ansible.self_link
}