# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "projects/cloud-2255/global/networks/vpc"
resource "google_compute_network" "my-network" {
  auto_create_subnetworks                   = true
  delete_default_routes_on_create           = false
  description                               = null
  enable_ula_internal_ipv6                  = false
  internal_ipv6_range                       = null
  mtu                                       = 0
  name                                      = "vpc"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  project                                   = "cloud-2255"
  routing_mode                              = "REGIONAL"
}

# __generated__ by Terraform from "projects/cloud-2255/zones/us-central1-c/instances/vm55"
resource "google_compute_instance" "vm2" {
  allow_stopping_for_update = null
  can_ip_forward            = false
  deletion_protection       = false
  description               = null
  desired_status            = null
  enable_display            = false
  guest_accelerator         = []
  hostname                  = null
  labels                    = {}
  machine_type              = "n1-standard-1"
  metadata                  = {}
  metadata_startup_script   = null
  min_cpu_platform          = null
  name                      = "vm55"
  project                   = "cloud-2255"
  resource_policies         = []
  tags                      = []
  zone                      = "us-central1-c"
  boot_disk {
    auto_delete             = true
    device_name             = "persistent-disk-0"
    disk_encryption_key_raw = null # sensitive
    kms_key_self_link       = null
    mode                    = "READ_WRITE"
    source                  = "https://www.googleapis.com/compute/v1/projects/cloud-2255/zones/us-central1-c/disks/vm55"
    initialize_params {
      enable_confidential_compute = false
      image                       = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-11-bullseye-v20240709"
      labels                      = {}
      provisioned_iops            = 0
      provisioned_throughput      = 0
      resource_manager_tags       = {}
      size                        = 10
      type                        = "pd-standard"
    }
  }
  network_interface {
    internal_ipv6_prefix_length = 0
    ipv6_address                = null
    network                     = "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/vpc"
    network_ip                  = "10.128.0.2"
    nic_type                    = null
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/vpc"
    subnetwork_project          = "cloud-2255"
    access_config {
      nat_ip                 = "35.232.217.172"
      network_tier           = "PREMIUM"
      public_ptr_domain_name = null
    }
  }
  scheduling {
    automatic_restart           = true
    instance_termination_action = null
    min_node_cpus               = 0
    on_host_maintenance         = "MIGRATE"
    preemptible                 = false
    provisioning_model          = "STANDARD"
  }
  service_account {
    email  = "798892868673-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}

# __generated__ by Terraform from "projects/cloud-2255/zones/us-central1-c/instances/vm45"
resource "google_compute_instance" "vm1" {
  allow_stopping_for_update = null
  can_ip_forward            = false
  deletion_protection       = false
  description               = null
  desired_status            = null
  enable_display            = false
  guest_accelerator         = []
  hostname                  = null
  labels                    = {}
  machine_type              = "n1-standard-1"
  metadata                  = {}
  metadata_startup_script   = null
  min_cpu_platform          = null
  name                      = "vm45"
  project                   = "cloud-2255"
  resource_policies         = []
  tags                      = []
  zone                      = "us-central1-c"
  boot_disk {
    auto_delete             = true
    device_name             = "persistent-disk-0"
    disk_encryption_key_raw = null # sensitive
    kms_key_self_link       = null
    mode                    = "READ_WRITE"
    source                  = "https://www.googleapis.com/compute/v1/projects/cloud-2255/zones/us-central1-c/disks/vm45"
    initialize_params {
      enable_confidential_compute = false
      image                       = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-11-bullseye-v20240709"
      labels                      = {}
      provisioned_iops            = 0
      provisioned_throughput      = 0
      resource_manager_tags       = {}
      size                        = 10
      type                        = "pd-standard"
    }
  }
  network_interface {
    internal_ipv6_prefix_length = 0
    ipv6_address                = null
    network                     = "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/vpc"
    network_ip                  = "10.128.0.3"
    nic_type                    = null
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/vpc"
    subnetwork_project          = "cloud-2255"
    access_config {
      nat_ip                 = "34.45.26.17"
      network_tier           = "PREMIUM"
      public_ptr_domain_name = null
    }
  }
  scheduling {
    automatic_restart           = true
    instance_termination_action = null
    min_node_cpus               = 0
    on_host_maintenance         = "MIGRATE"
    preemptible                 = false
    provisioning_model          = "STANDARD"
  }
  service_account {
    email  = "798892868673-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}
