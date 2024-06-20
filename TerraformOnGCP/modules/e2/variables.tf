variable "instance_name" {
  description = "e2-instance"
  type = string
  default = "demo"
}

variable "machine_type" {
    description = "machine type e2-standard-1"
    type = string 
    default = "e2-standard-1"
}

variable "image" {
  description = "image type ubuntu-os-cloud/ubuntu-2004-lts"
  type = string
}