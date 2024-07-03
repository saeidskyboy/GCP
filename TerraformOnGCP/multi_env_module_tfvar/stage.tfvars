{
  "version": 4,
  "terraform_version": "1.8.4",
  "serial": 4,
  "lineage": "250aa42d-0b1b-c560-68fb-b4e20261d4ad",
  "outputs": {},
  "resources": [
    {
      "module": "module.vm",
      "mode": "managed",
      "type": "google_compute_instance",
      "name": "vm_instance",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 6,
          "attributes": {
            "advanced_machine_features": [],
            "allow_stopping_for_update": null,
            "attached_disk": [],
            "boot_disk": [
              {
                "auto_delete": true,
                "device_name": "persistent-disk-0",
                "disk_encryption_key_raw": "",
                "disk_encryption_key_sha256": "",
                "initialize_params": [
                  {
                    "enable_confidential_compute": false,
                    "image": "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-11-bullseye-v20240611",
                    "labels": {},
                    "provisioned_iops": 0,
                    "provisioned_throughput": 0,
                    "resource_manager_tags": null,
                    "size": 10,
                    "type": "pd-standard"
                  }
                ],
                "kms_key_self_link": "",
                "mode": "READ_WRITE",
                "source": "https://www.googleapis.com/compute/v1/projects/cloud-2255/zones/us-central1-b/disks/stage-vm-f7"
              }
            ],
            "can_ip_forward": false,
            "confidential_instance_config": [],
            "cpu_platform": "Intel Broadwell",
            "current_status": "RUNNING",
            "deletion_protection": false,
            "description": "",
            "desired_status": null,
            "effective_labels": {},
            "enable_display": false,
            "guest_accelerator": [],
            "hostname": "",
            "id": "projects/cloud-2255/zones/us-central1-b/instances/stage-vm-f7",
            "instance_id": "7635993444928196791",
            "label_fingerprint": "42WmSpB8rSM=",
            "labels": null,
            "machine_type": "e2-micro",
            "metadata": {
              "environment": "stage"
            },
            "metadata_fingerprint": "_MgGnJioOG8=",
            "metadata_startup_script": null,
            "min_cpu_platform": "",
            "name": "stage-vm-f7",
            "network_interface": [
              {
                "access_config": [],
                "alias_ip_range": [],
                "internal_ipv6_prefix_length": 0,
                "ipv6_access_config": [],
                "ipv6_access_type": "",
                "ipv6_address": "",
                "name": "nic0",
                "network": "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/custome-vpc-stage",
                "network_ip": "10.0.8.2",
                "nic_type": "",
                "queue_count": 0,
                "stack_type": "IPV4_ONLY",
                "subnetwork": "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/subnet-test1-stage",
                "subnetwork_project": "cloud-2255"
              }
            ],
            "network_performance_config": [],
            "params": [],
            "project": "cloud-2255",
            "reservation_affinity": [],
            "resource_policies": null,
            "scheduling": [
              {
                "automatic_restart": true,
                "instance_termination_action": "",
                "local_ssd_recovery_timeout": [],
                "min_node_cpus": 0,
                "node_affinities": [],
                "on_host_maintenance": "MIGRATE",
                "preemptible": false,
                "provisioning_model": "STANDARD"
              }
            ],
            "scratch_disk": [],
            "self_link": "https://www.googleapis.com/compute/v1/projects/cloud-2255/zones/us-central1-b/instances/stage-vm-f7",
            "service_account": [],
            "shielded_instance_config": [
              {
                "enable_integrity_monitoring": true,
                "enable_secure_boot": false,
                "enable_vtpm": true
              }
            ],
            "tags": null,
            "tags_fingerprint": "42WmSpB8rSM=",
            "terraform_labels": {},
            "timeouts": null,
            "zone": "us-central1-b"
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "boot_disk"
              },
              {
                "type": "index",
                "value": {
                  "value": 0,
                  "type": "number"
                }
              },
              {
                "type": "get_attr",
                "value": "disk_encryption_key_raw"
              }
            ]
          ],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiNiJ9",
          "dependencies": [
            "module.vpc.google_compute_network.vpc_network",
            "module.vpc.google_compute_subnetwork.vpc_subnetwork"
          ]
        },
        {
          "index_key": 1,
          "schema_version": 6,
          "attributes": {
            "advanced_machine_features": [],
            "allow_stopping_for_update": null,
            "attached_disk": [],
            "boot_disk": [
              {
                "auto_delete": true,
                "device_name": "persistent-disk-0",
                "disk_encryption_key_raw": "",
                "disk_encryption_key_sha256": "",
                "initialize_params": [
                  {
                    "enable_confidential_compute": false,
                    "image": "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-11-bullseye-v20240611",
                    "labels": {},
                    "provisioned_iops": 0,
                    "provisioned_throughput": 0,
                    "resource_manager_tags": null,
                    "size": 10,
                    "type": "pd-standard"
                  }
                ],
                "kms_key_self_link": "",
                "mode": "READ_WRITE",
                "source": "https://www.googleapis.com/compute/v1/projects/cloud-2255/zones/us-central1-c/disks/stage-vm-t7"
              }
            ],
            "can_ip_forward": false,
            "confidential_instance_config": [],
            "cpu_platform": "Intel Broadwell",
            "current_status": "RUNNING",
            "deletion_protection": false,
            "description": "",
            "desired_status": null,
            "effective_labels": {},
            "enable_display": false,
            "guest_accelerator": [],
            "hostname": "",
            "id": "projects/cloud-2255/zones/us-central1-c/instances/stage-vm-t7",
            "instance_id": "6608936510981410999",
            "label_fingerprint": "42WmSpB8rSM=",
            "labels": null,
            "machine_type": "e2-micro",
            "metadata": {
              "environment": "stage"
            },
            "metadata_fingerprint": "_MgGnJioOG8=",
            "metadata_startup_script": null,
            "min_cpu_platform": "",
            "name": "stage-vm-t7",
            "network_interface": [
              {
                "access_config": [],
                "alias_ip_range": [],
                "internal_ipv6_prefix_length": 0,
                "ipv6_access_config": [],
                "ipv6_access_type": "",
                "ipv6_address": "",
                "name": "nic0",
                "network": "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/custome-vpc-stage",
                "network_ip": "10.0.9.2",
                "nic_type": "",
                "queue_count": 0,
                "stack_type": "IPV4_ONLY",
                "subnetwork": "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/subnet-t2-stage",
                "subnetwork_project": "cloud-2255"
              }
            ],
            "network_performance_config": [],
            "params": [],
            "project": "cloud-2255",
            "reservation_affinity": [],
            "resource_policies": null,
            "scheduling": [
              {
                "automatic_restart": true,
                "instance_termination_action": "",
                "local_ssd_recovery_timeout": [],
                "min_node_cpus": 0,
                "node_affinities": [],
                "on_host_maintenance": "MIGRATE",
                "preemptible": false,
                "provisioning_model": "STANDARD"
              }
            ],
            "scratch_disk": [],
            "self_link": "https://www.googleapis.com/compute/v1/projects/cloud-2255/zones/us-central1-c/instances/stage-vm-t7",
            "service_account": [],
            "shielded_instance_config": [
              {
                "enable_integrity_monitoring": true,
                "enable_secure_boot": false,
                "enable_vtpm": true
              }
            ],
            "tags": null,
            "tags_fingerprint": "42WmSpB8rSM=",
            "terraform_labels": {},
            "timeouts": null,
            "zone": "us-central1-c"
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "boot_disk"
              },
              {
                "type": "index",
                "value": {
                  "value": 0,
                  "type": "number"
                }
              },
              {
                "type": "get_attr",
                "value": "disk_encryption_key_raw"
              }
            ]
          ],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiNiJ9",
          "dependencies": [
            "module.vpc.google_compute_network.vpc_network",
            "module.vpc.google_compute_subnetwork.vpc_subnetwork"
          ]
        },
        {
          "index_key": 2,
          "schema_version": 6,
          "attributes": {
            "advanced_machine_features": [],
            "allow_stopping_for_update": null,
            "attached_disk": [],
            "boot_disk": [
              {
                "auto_delete": true,
                "device_name": "persistent-disk-0",
                "disk_encryption_key_raw": "",
                "disk_encryption_key_sha256": "",
                "initialize_params": [
                  {
                    "enable_confidential_compute": false,
                    "image": "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-11-bullseye-v20240611",
                    "labels": {},
                    "provisioned_iops": 0,
                    "provisioned_throughput": 0,
                    "resource_manager_tags": null,
                    "size": 10,
                    "type": "pd-standard"
                  }
                ],
                "kms_key_self_link": "",
                "mode": "READ_WRITE",
                "source": "https://www.googleapis.com/compute/v1/projects/cloud-2255/zones/us-central1-f/disks/stage-vm-c7"
              }
            ],
            "can_ip_forward": false,
            "confidential_instance_config": [],
            "cpu_platform": "Intel Broadwell",
            "current_status": "RUNNING",
            "deletion_protection": false,
            "description": "",
            "desired_status": null,
            "effective_labels": {},
            "enable_display": false,
            "guest_accelerator": [],
            "hostname": "",
            "id": "projects/cloud-2255/zones/us-central1-f/instances/stage-vm-c7",
            "instance_id": "1515616089795989687",
            "label_fingerprint": "42WmSpB8rSM=",
            "labels": null,
            "machine_type": "e2-micro",
            "metadata": {
              "environment": "stage"
            },
            "metadata_fingerprint": "_MgGnJioOG8=",
            "metadata_startup_script": null,
            "min_cpu_platform": "",
            "name": "stage-vm-c7",
            "network_interface": [
              {
                "access_config": [],
                "alias_ip_range": [],
                "internal_ipv6_prefix_length": 0,
                "ipv6_access_config": [],
                "ipv6_access_type": "",
                "ipv6_address": "",
                "name": "nic0",
                "network": "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/custome-vpc-stage",
                "network_ip": "10.0.12.2",
                "nic_type": "",
                "queue_count": 0,
                "stack_type": "IPV4_ONLY",
                "subnetwork": "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/subnet-c1-tage",
                "subnetwork_project": "cloud-2255"
              }
            ],
            "network_performance_config": [],
            "params": [],
            "project": "cloud-2255",
            "reservation_affinity": [],
            "resource_policies": null,
            "scheduling": [
              {
                "automatic_restart": true,
                "instance_termination_action": "",
                "local_ssd_recovery_timeout": [],
                "min_node_cpus": 0,
                "node_affinities": [],
                "on_host_maintenance": "MIGRATE",
                "preemptible": false,
                "provisioning_model": "STANDARD"
              }
            ],
            "scratch_disk": [],
            "self_link": "https://www.googleapis.com/compute/v1/projects/cloud-2255/zones/us-central1-f/instances/stage-vm-c7",
            "service_account": [],
            "shielded_instance_config": [
              {
                "enable_integrity_monitoring": true,
                "enable_secure_boot": false,
                "enable_vtpm": true
              }
            ],
            "tags": null,
            "tags_fingerprint": "42WmSpB8rSM=",
            "terraform_labels": {},
            "timeouts": null,
            "zone": "us-central1-f"
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "boot_disk"
              },
              {
                "type": "index",
                "value": {
                  "value": 0,
                  "type": "number"
                }
              },
              {
                "type": "get_attr",
                "value": "disk_encryption_key_raw"
              }
            ]
          ],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiNiJ9",
          "dependencies": [
            "module.vpc.google_compute_network.vpc_network",
            "module.vpc.google_compute_subnetwork.vpc_subnetwork"
          ]
        }
      ]
    },
    {
      "module": "module.vpc",
      "mode": "managed",
      "type": "google_compute_network",
      "name": "vpc_network",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "auto_create_subnetworks": false,
            "delete_default_routes_on_create": false,
            "description": "",
            "enable_ula_internal_ipv6": false,
            "gateway_ipv4": "",
            "id": "projects/cloud-2255/global/networks/custome-vpc-stage",
            "internal_ipv6_range": "",
            "mtu": 0,
            "name": "custome-vpc-stage",
            "network_firewall_policy_enforcement_order": "AFTER_CLASSIC_FIREWALL",
            "numeric_id": "4664729550522421499",
            "project": "cloud-2255",
            "routing_mode": "REGIONAL",
            "self_link": "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/custome-vpc-stage",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19"
        }
      ]
    },
    {
      "module": "module.vpc",
      "mode": "managed",
      "type": "google_compute_subnetwork",
      "name": "vpc_subnetwork",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 0,
          "attributes": {
            "creation_timestamp": "2024-07-03T13:01:57.100-07:00",
            "description": "",
            "external_ipv6_prefix": "",
            "fingerprint": null,
            "gateway_address": "10.0.8.1",
            "id": "projects/cloud-2255/regions/us-central1/subnetworks/subnet-test1-stage",
            "internal_ipv6_prefix": "",
            "ip_cidr_range": "10.0.8.0/24",
            "ipv6_access_type": "",
            "ipv6_cidr_range": "",
            "log_config": [],
            "name": "subnet-test1-stage",
            "network": "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/custome-vpc-stage",
            "private_ip_google_access": false,
            "private_ipv6_google_access": "DISABLE_GOOGLE_ACCESS",
            "project": "cloud-2255",
            "purpose": "PRIVATE",
            "region": "us-central1",
            "role": "",
            "secondary_ip_range": [],
            "self_link": "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/subnet-test1-stage",
            "stack_type": "IPV4_ONLY",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "module.vpc.google_compute_network.vpc_network"
          ]
        },
        {
          "index_key": 1,
          "schema_version": 0,
          "attributes": {
            "creation_timestamp": "2024-07-03T13:01:57.022-07:00",
            "description": "",
            "external_ipv6_prefix": "",
            "fingerprint": null,
            "gateway_address": "10.0.9.1",
            "id": "projects/cloud-2255/regions/us-central1/subnetworks/subnet-t2-stage",
            "internal_ipv6_prefix": "",
            "ip_cidr_range": "10.0.9.0/24",
            "ipv6_access_type": "",
            "ipv6_cidr_range": "",
            "log_config": [],
            "name": "subnet-t2-stage",
            "network": "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/custome-vpc-stage",
            "private_ip_google_access": false,
            "private_ipv6_google_access": "DISABLE_GOOGLE_ACCESS",
            "project": "cloud-2255",
            "purpose": "PRIVATE",
            "region": "us-central1",
            "role": "",
            "secondary_ip_range": [],
            "self_link": "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/subnet-t2-stage",
            "stack_type": "IPV4_ONLY",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "module.vpc.google_compute_network.vpc_network"
          ]
        },
        {
          "index_key": 2,
          "schema_version": 0,
          "attributes": {
            "creation_timestamp": "2024-07-03T13:01:57.124-07:00",
            "description": "",
            "external_ipv6_prefix": "",
            "fingerprint": null,
            "gateway_address": "10.0.12.1",
            "id": "projects/cloud-2255/regions/us-central1/subnetworks/subnet-c1-tage",
            "internal_ipv6_prefix": "",
            "ip_cidr_range": "10.0.12.0/24",
            "ipv6_access_type": "",
            "ipv6_cidr_range": "",
            "log_config": [],
            "name": "subnet-c1-tage",
            "network": "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/custome-vpc-stage",
            "private_ip_google_access": false,
            "private_ipv6_google_access": "DISABLE_GOOGLE_ACCESS",
            "project": "cloud-2255",
            "purpose": "PRIVATE",
            "region": "us-central1",
            "role": "",
            "secondary_ip_range": [],
            "self_link": "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/subnet-c1-tage",
            "stack_type": "IPV4_ONLY",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "module.vpc.google_compute_network.vpc_network"
          ]
        },
        {
          "index_key": 3,
          "schema_version": 0,
          "attributes": {
            "creation_timestamp": "2024-07-03T13:01:57.129-07:00",
            "description": "",
            "external_ipv6_prefix": "",
            "fingerprint": null,
            "gateway_address": "10.0.32.1",
            "id": "projects/cloud-2255/regions/us-central1/subnetworks/subnet-c7-stage",
            "internal_ipv6_prefix": "",
            "ip_cidr_range": "10.0.32.0/24",
            "ipv6_access_type": "",
            "ipv6_cidr_range": "",
            "log_config": [],
            "name": "subnet-c7-stage",
            "network": "https://www.googleapis.com/compute/v1/projects/cloud-2255/global/networks/custome-vpc-stage",
            "private_ip_google_access": false,
            "private_ipv6_google_access": "DISABLE_GOOGLE_ACCESS",
            "project": "cloud-2255",
            "purpose": "PRIVATE",
            "region": "us-central1",
            "role": "",
            "secondary_ip_range": [],
            "self_link": "https://www.googleapis.com/compute/v1/projects/cloud-2255/regions/us-central1/subnetworks/subnet-c7-stage",
            "stack_type": "IPV4_ONLY",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "module.vpc.google_compute_network.vpc_network"
          ]
        }
      ]
    }
  ],
  "check_results": null
}

