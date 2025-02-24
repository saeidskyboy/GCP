variable "instance_names" {
  type = list(string)
  description = "List of VM instance names"
}

variable "machine_type" {
  type = string
  description = "value of machine type"
}

variable "zones" {
  type = list(string)
  description = "value of zones for our instances"
}

variable "image" {
  type = string
  description = "our boot disk source to boot our instance"
}

variable "subnet_ids" {
  type = list(string)
  description = "list of subnet ids to tatch to our instances"
}