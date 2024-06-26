variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnetwork"
}

variable "subnet_ip_range" {
  type        = string
  description = "IP CIDR range for the subnet"
}

variable "subnet_region" {
  type        = string
  description = "Region for the subnet (e.g., us-central1)"
}
