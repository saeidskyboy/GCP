# modules/vm/variables.tf

variable "instances" {
  type = map(object({
    zone         = string
    machine_type = string
    image        = string
    subnet       = string
  }))
  description = "Map of instances to create, with name as key."
}

variable "network_id" {
  type        = string
  description = "The ID of the VPC network to attach instances to."
}

variable "subnet_ids" {
  type = map(string)
  description = "Map of subnet names to their IDs"
}
