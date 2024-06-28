variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_names" {
  type        = list(string)
  description = "List of subnetwork names"
}

variable "subnet_ip_ranges" {
  type        = list(string)
  description = "List of IP CIDR ranges for the subnets"
}

variable "subnet_region" {
  type        = string
  description = "Region for the subnets (e.g., us-central1)"
}

variable "instance_names" {
  type        = list(string)
  description = "List of VM instance names"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the instances"
}

variable "zones" {
  type        = list(string)
  description = "List of zones for the instances (e.g., [\"us-central1-a\", \"us-central1-b\"])"
}

variable "image" {
  type        = string
  description = "Source image for the instances' boot disks"
}