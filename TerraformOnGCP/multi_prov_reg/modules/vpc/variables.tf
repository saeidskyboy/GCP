variable "google_compute_network" {
  type        = string
  description = "The name of the VPC network."
}

variable "auto_create_subnetworks" {
  type        = bool
  default     = false
  description = "Whether to auto-create subnetworks."
}

variable "subnets" {
  type = map(object({
    region        = string
    ip_cidr_range = string
  }))
  description = "Map of subnets to create, with name as key."
}
