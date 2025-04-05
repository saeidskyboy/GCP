#!/bin/bash
# File: startup-script.sh (or scripts/your_script_name.sh)
set -e # Exit immediately if a command exits with a non-zero status.

echo "### Updating package list ###"
apt-get update -y

echo "### Installing prerequisites: python3, pip, git ###"
apt-get install -y python3 python3-pip git

echo "### Installing Ansible via pip ###"
pip3 install ansible

# echo "### Generating SSH key for Ansible Controller ###"
# # Define key path (using root's home dir as scripts often run as root)
# KEY_PATH="/root/.ssh/id_ed25519_ansible_controller"
# # Use single $ for shell execution
# KEY_DIR=$(dirname "$KEY_PATH")
# KEY_COMMENT="ansible-controller"

# Ensure .ssh directory exists with correct permissions (700)
# Use single $ for shell execution
# mkdir -p "$KEY_DIR"
# chmod 700 "$KEY_DIR"

# Generate the ed25519 key pair without a passphrase (-N '')
# Use single $ for shell execution
# ssh-keygen -t ed25519 -f "$KEY_PATH" -N '' -C "$KEY_COMMENT"

# echo "### Setting key permissions ###"
# # Use single $ or ${} for shell execution
# chmod 600 "${KEY_PATH}"     # Private key readable only by owner
# chmod 644 "${KEY_PATH}.pub" # Public key readable by all

# echo "### Ansible Controller Public Key Output ###"
# # Use single $ or ${} for shell execution
# echo "--- START ANSIBLE CONTROLLER PUBLIC KEY (${KEY_PATH}.pub) ---"
# cat "${KEY_PATH}.pub"
# echo "--- END ANSIBLE CONTROLLER PUBLIC KEY ---"
# echo "### Startup script finished ###"