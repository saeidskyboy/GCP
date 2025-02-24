variable "vpc_name" {
  type = string
  description = "Name of the VPC network"
}

variable "subnet_names" {
  type = list(string)
  description = "list of subnet names"
}

variable "subnet_ip_ranges" {
  type = list(string)
  description = "list of IP cidr ranges for the subnets"
}

variable "subnet_region" {
  type = string
  description = "region for the subnets"
}