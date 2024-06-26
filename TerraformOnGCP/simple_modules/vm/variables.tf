variable "instance_name" {
  type        = string
  description = "Name of the VM instance"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the instance"
}

variable "zone" {
  type        = string
  description = "Zone for the instance (e.g., us-central1-a)"
}

variable "image" {
  type        = string
  description = "Source image for the instance's boot disk"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to attach the instance to"
}
     